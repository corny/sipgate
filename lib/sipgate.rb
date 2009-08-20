require 'xmlrpc/client'

class Sipgate
  
  cattr_accessor :user, :password
  
  def initialize
    @client = XMLRPC::Client.new2("https://#{self.class.user}:#{self.class.password}@samurai.sipgate.net/RPC2")
    http    = @client.instance_variable_get(:@http)
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.ca_path = '/etc/ssl/certs'
  end
  
  # versendet ein Fax
  def fax(number, pdf_message)
    number = number.gsub(/^(\+)/, "").gsub(/\s+/,   "")
    
    call "samurai.SessionInitiate",
         'RemoteUri' => "sip:#{number}@sipgate.net",
         'TOS'       => 'fax',
         'Content'   => Base64.encode64(pdf_message)
  end
  
  # fragt den Status eines Faxes ab
  def status(session_id)
    call "samurai.SessionStatusGet",
         'SessionID' => session_id
  end
  
  def call(*args)
    response = Response.new(rubyized_hash(@client.call(*args)))
    
    unless response.success?
      raise Sipgate::Exception.new(response.status_string, response.status_code)
    end
    
    response
  end
  
  # make server responses look more Ruby like (underscored Symbol as Hash keys)
  # source: http://github.com/martinrehfeld/telefon/blob/7133964255eefb4679d8759f467ec2f749459aaa/app/models/sipgate.rb
  def rubyized_hash(h)
    returning new_hash = {} do
      h.each do |k,v|
        new_val = if v.is_a?(Hash)
          rubyized_hash(v)
        elsif v.is_a?(Array)
          v.map{|e| e.is_a?(Hash) ? rubyized_hash(e) : e}
        else
          v
        end
        new_hash[k.to_s.underscore.to_sym] = new_val
      end
    end
  end
  
end
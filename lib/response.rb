class Sipgate::Response
  
  CODE_SUCCESS = 200
  
  def initialize(response)
    @response = response
  end
  
  def success?
    status_code == CODE_SUCCESS
  end
  
  def session_id
    @response[:session_id]
  end
  
  def session_status
    @response[:session_status]
  end
  
  def status_code
    @response[:status_code]
  end
  
  def status_string
    @response[:status_string]
  end
  
  # gibt den Status eines Fax-Versandes zurück. Mögliche Antworten:
  # :pending, :sent, :failed
  def sending_status
    case session_status
      when "sending", "queued"
        :pending
      when "sent"
        :sent
      when "error during submit", "failed"
        :failed
      else
        raise "Konnte keinen Status aus Antwort ermitteln: #{inspect}"
    end
  end
  
end
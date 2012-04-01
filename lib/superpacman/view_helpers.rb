module SuperPacMan
  module ViewHelpers
  
    def getFecFiling
      filing = Fech::Filing.new(723604)
      filing.download
      filing.summary
    end
    
    def displayHash(hash)
      result = ''
      hash.each do |row|
        result << "<strong>#{row[0]}:</strong> #{row[1]} <br />"
      end
      result
    
    end
  
    def current_menu
      @current_menu
    end
    
    def current_menu_class(menu_name)
      return "current" if current_menu == menu_name
    end
    
    def format_number(number)
      integer_part = number.to_i
      integer_part_string = integer_part.to_s.reverse.gsub(/(\d{3}(?=(\d)))/, "\\1,").reverse
      
      "#{integer_part_string}"
    end
    
    def encode_element_id(s)
      URI::encode(s.gsub(" ", "-"))
    end
    
    def decode_element_id(s)
      URI::decode(s.gsub("-", " "))
    end

  end
end

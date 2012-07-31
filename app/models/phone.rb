class Phone < ActiveRecord::Base

  attr_accessible :name, :number

  validates :name, presence: true, uniqueness: true

  def self.to_text
    Phone.all.map{ |phone| "#{phone.updated_at}\t#{phone.name}\t#{phone.number}" }.join("\r\n")
  end

  def self.from_text(phonebook_file)
    phonebook_file.each_line do |line|
      phone = line.split("\t")
      updated_at = nil
      begin
        updated_at = Time.parse(phone[0])
      rescue ArgumentError => ignored
      end
      name = phone[1]
      number = phone[2]
      if updated_at && name
        exist_phone = Phone.where(name: name).first
        if exist_phone
          if exist_phone.updated_at < updated_at
            exist_phone.number = number
            exist_phone.save
          end
        else
          Phone.create(name: name, number: number)
        end
      end
    end
  end
end

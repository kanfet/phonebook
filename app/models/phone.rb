class Phone < ActiveRecord::Base

  attr_accessible :name, :number

  validates :name, presence: true

  def self.to_text
    Phone.all.map{ |phone| "#{phone.name}\t#{phone.number}" }.join("\r\n")
  end

  def self.from_text(phonebook_file)
    # simplest sync way: delete all phones, add all phones from file
    Phone.destroy_all
    phonebook_file.each_line do |line|
      phone = line.split("\t")
      Phone.create(name: phone[0], number: phone[1]) if phone[0]
    end
  end
end

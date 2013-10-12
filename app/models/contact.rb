class Contact < ActiveRecord::Base
	belongs_to :user
	has_many :accounting_records, :dependent => :destroy

	validates_presence_of :user
	validates_presence_of :name
	validates_presence_of :email

	validates_length_of :name, :maximum => 50
	validates_length_of :email, :maximum => 60
	validates_length_of :phone, :maximum => 15
	validates_length_of :mobile, :maximum => 15
	validates_length_of :address, :maximum => 255

	scope :with_virtual_statistics, -> {
		select(
			"contacts.*,
			(
				SELECT SUM(accounting_records.value) FROM accounting_records WHERE accounting_records.is_active is TRUE AND accounting_records.contact_id = contacts.id AND accounting_records.record_type = 'credit'
			) AS total_credit,
			(
				SELECT SUM(accounting_records.value) FROM accounting_records WHERE accounting_records.is_active is TRUE AND accounting_records.contact_id = contacts.id AND accounting_records.record_type = 'debt'
			) AS total_debt"
		)
	}

end

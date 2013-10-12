class AccountingRecord < ActiveRecord::Base
	belongs_to :contact
	has_one :user, :through => :contact

	validates_presence_of :contact
	validates_presence_of :value
	validates_presence_of :record_type

	validates_numericality_of :value
	validates_numericality_of :bank_rate

	validates_inclusion_of :record_type, :in => [nil, "debt", "credit"]

	validates_length_of :note, :maximum => 500

	accepts_nested_attributes_for :contact

	default_scope { includes(:contact)}

	def get_record_type_s
		self.record_type == "debt" ? "Borç" : "Alacak"
	end

	def get_total_value
		return self.value if self.due_date.nil? || self.bank_rate.nil?
		self.value + self.value * self.bank_rate * (self.due_date - self.created_at) / 2592000 / 100
	end

	def status
		self.is_active? ? "Aktif" : "Pasif"
	end

end
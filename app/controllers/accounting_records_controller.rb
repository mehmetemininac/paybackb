# encoding: utf-8
class AccountingRecordsController < ApplicationController
	before_filter :authenticate_user!
	before_action :find_record, :only => [:show, :edit, :destroy, :payed, :publish_on_facebook, :update]
	before_action :prepare_sub_menu

	def index
		@accounting_records = current_user.accounting_records.paginate(:page => params[:page], :per_page => 20)
	end

	def destroy
		@record.destroy ? flash[:success] = "Kayıt silindi" : flash[:alert] = "Hata oluştu"
		redirect_to :action => :index
	end

	def edit
	end

	def show
	end

	def update
		if @record.update_attributes(get_permitted_parameters)
			flash[:success] = "Kayıt güncellendi"
			redirect_to :action => :index
		else
			render :action => :edit
		end
	end

	def publish_on_facebook
		success = true
		begin
			current_user.facebook.feed!(
				:message => "#{@record.contact.name} sana verdiğim #{@record.value} ne oldu ?",
				:name => 'paybackb'
			)
		rescue
			success = false
		end
		success ? flash[:success] = "İçerik paylaşıldı..." : flash[:alert] = "İçerik paylaşımı sırasında hata oluştu, lütfen tekrar deneyin."
		redirect_to :back
	end

	def payed
		@result = @record.update_attribute(:is_active, false)
		respond_to do |format|
			format.html { render :text => "This action requires js requests" }
			format.js { render :layout => false }
		end
	end

	def create
		@record = AccountingRecord.new(get_permitted_parameters)
		@record = current_user.accounting_records.build(get_permitted_parameters)
		@record.contact.user = current_user
		if @record.save
			flash[:success] = "Kayıt eklendi"
			redirect_to accounting_records_path
		else
			@contacts = current_user.contacts
			@record.contact.id = nil
			render :action => @record.record_type == "credit" ? :new_credit : :new_debt
		end
	end

	def new_credit
		init_record("credit")
	end

	def new_debt
		init_record("debt")
	end

private
	def find_record
		@record = AccountingRecord.find(params[:id])
		if @record.user.id != current_user.id
			flash[:alert] = "Bu içeriği görüntüleme yetkiniz bulunmamakta!"
			return redirect_to accounting_records_path
		end
	end

	def prepare_sub_menu
		@sub_menu_elements = [
			{:text => "Kayıt Listesi", :to => accounting_records_path},
			{:text => "Alacak Ekle", :to => new_credit_accounting_records_path},
			{:text => "Borç Ekle", :to => new_debt_accounting_records_path}
		]
	end

	def init_record(record_type)
		@record = AccountingRecord.new(:record_type => record_type)
		@record.build_contact
		@contacts = current_user.contacts
	end

	def get_permitted_parameters
		params.require(:accounting_record).permit(:value, :bank_rate, :due_date, :contact_id, :record_type, :note, :contact_attributes => [:id, :name, :email, :phone, :mobile, :address])
	end

end

# encoding: utf-8
class ContactsController < ApplicationController
	before_filter :authenticate_user!
	before_action :find_contact, :only => [:show, :edit, :destroy, :update]
	before_action :prepare_sub_menu

	def index
		@contacts = current_user.contacts.paginate(:page => params[:page], :per_page => 20)
	end

	def new
		@contact = Contact.new
	end

	def show
	end

	def edit
	end

	def update
		if @contact.update_attributes(get_permitted_parameters)
			flash[:success] = "Kişi kaydı güncellendi"
			redirect_to :action => :index
		else
			render :action => :edit
		end
	end

	def create
		@contact = current_user.contacts.build(get_permitted_parameters)
		if @contact.save
			flash[:success] = "Kişi kaydı eklendi"
			redirect_to :action => :index
		else
			render :action => :new
		end
	end

	def destroy
		@contact.destroy ? flash[:success] = "Kişi silindi" : flash[:alert] = "Hata oluştu"
		redirect_to :action => :index
	end

private
	def find_contact
		@contact = Contact.with_virtual_statistics.find(params[:id])
		if @contact.user.id != current_user.id
			flash[:alert] = "Bu içeriği görüntüleme yetkiniz yok!"
			return redirect_to contacts_path
		end
	end
	def prepare_sub_menu
		@sub_menu_elements = [
			{:text => "Kişiler Listesi", :to => contacts_path},
			{:text => "Kişi Ekle", :to => new_contact_path}
		]
	end

	def get_permitted_parameters
		params.require(:contact).permit(:name, :email, :phone, :mobile, :address)
	end

end

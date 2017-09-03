class ContactsController < ApplicationController
  def create
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.new(contact_params)
    if @contact.save
      flash[:success] = "#{@contact.name} added!"
      redirect_to company_path(params[:company_id])
    else
      redirect_to company_path(params[:company_id])
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :position, :email)
  end
end

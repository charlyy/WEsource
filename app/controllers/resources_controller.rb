class ResourcesController < ApplicationController
before_action :set_resource, :only => [:show, :edit, :update, :destroy]
respond_to :json, :html

	def index
		@resources = Resource.all
		respond_with @resources
	end

	def new
		@resource = Resource.new
	end

	def show
		respond_with @resource
	end

	def create
		@resource = Resource.new(resource_params)
		
		if @resource.save
			flash[:success] = "Your WEsource has been created!"
			respond_to do |format|
		        format.html { redirect_to resources_path }
		        format.json { render json: @resource, status: :created }
		    end
	    else
	      	respond_to do |format|
		        format.html { render 'new' }
		        format.json { render json: @resource.errors, status: :unprocessable_entity }
	        end
		end
	end

	def edit
	end

	def update
		if @resource.update(resource_params)
		      respond_to do |format|
		        format.html { redirect_to resources_path }
		        format.json { render nothing: true, status: :no_content }
		      end
		    else
		      respond_to do |format|
		        format.html { render 'edit' }
		        format.json { render json: @resource.errors, status: :unprocessable_entity }
		      end
		end
	end

	def destroy
		@resource.destroy

		respond_to do |format|
			format.html { redirect_to resources_path }
			format.json { render json: { head: :ok } }
		end
	end
	
	protected

	def set_resource
		@resource = Resource.find(params[:id])
	end

	def resource_params
		params.require(:resource).permit(:title, :language, :link, :note)
	end

end

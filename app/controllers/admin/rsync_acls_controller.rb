class Admin::RsyncAclsController < ApplicationController
  before_action :set_group
  before_action :set_server
  before_action :set_admin_rsync_acl, only: [:show, :edit, :update, :destroy]

  # GET /admin/rsync_acls
  def index
    # @admin_rsync_acls = current_user.all
  end

  # GET /admin/rsync_acls/1
  def show
  end

  # GET /admin/rsync_acls/new
  def new
    @admin_rsync_acl = RsyncAcl.new
  end

  # GET /admin/rsync_acls/1/edit
  def edit
  end

  # POST /admin/rsync_acls
  def create
    @admin_rsync_acl = RsyncAcl.new(admin_rsync_acl_params)

    if @admin_rsync_acl.save
      @server.rsync_acls << @admin_rsync_acl
      redirect_to admin_group_server_url(@group, @server), notice: 'Rsync acl was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/rsync_acls/1
  def update
    if @admin_rsync_acl.update(admin_rsync_acl_params)
      redirect_to admin_group_server_url(@group, @server), notice: 'Rsync acl was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/rsync_acls/1
  def destroy
    @admin_rsync_acl.destroy
    redirect_to admin_rsync_acls_url, notice: 'Rsync acl was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_rsync_acl
      @admin_rsync_acl = current_user.rsync_acls.find(params[:id])
    end

    def set_server
      @server = current_user.servers.find(params.permit(:server_id)[:server_id])
    end

    def set_group
      @group  = current_user.groups.where(id: params.permit(:group_id)[:group_id]).first
    end

    # Only allow a trusted parameter "white list" through.
    def admin_rsync_acl_params
      params.require(:rsync_acl).permit(:host)
    end
end
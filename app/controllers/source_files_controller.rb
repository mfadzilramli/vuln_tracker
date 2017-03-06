class SourceFilesController < ApplicationController
  before_action :set_source_file, only: [:show, :edit, :update, :destroy]

  # GET /source_files
  # GET /source_files.json
  def index
    @source_files = SourceFile.all
  end

  # GET /source_files/1
  # GET /source_files/1.json
  def show
    @affected_hosts = AffectedHost.where(source_file_id: params[:id])
    # @pie_data = get_pie_data(@affected_hosts)
    # @radar_data = get_radar_data(@affected_hosts)
  end

  # GET /source_files/new
  def new
    @source_file = SourceFile.new
  end

  # GET /source_files/1/edit
  def edit
  end

  # POST /source_files
  # POST /source_files.json
  def create
    @source_file = SourceFile.new(source_file_params) do |t|
      if params[:source_file][:data]
        t.data      = params[:source_file][:data].read
        t.filename  = params[:source_file][:data].original_filename
        t.mime_type = params[:source_file][:data].content_type
      end
    end

    respond_to do |format|
      if @source_file.save
        #write_to_db(@source_file)
        @source_file.to_csv
        format.html { redirect_to @source_file, notice: 'Source file was successfully created.' }
        format.json { render :show, status: :created, location: @source_file }
      else
        format.html { render :new }
        format.json { render json: @source_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /source_files/1
  # PATCH/PUT /source_files/1.json
  def update
    respond_to do |format|
      if @source_file.update(source_file_params)
        # format.html { redirect_to @source_file, notice: 'Source file was successfully updated.' }
        format.html { redirect_to source_files_path, notice: 'Source file was successfully updated.' }
        format.json { render :show, status: :ok, location: @source_file }
      else
        format.html { render :edit }
        format.json { render json: @source_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_files/1
  # DELETE /source_files/1.json
  def destroy
    @source_file.destroy
    respond_to do |format|
      format.html { redirect_to source_files_path, notice: 'Source file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_file
      @source_file = SourceFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_file_params
      params.fetch(:source_file, {}).permit(:title, :data)
    end

    def write_to_db(source_file)
      doc = Nokogiri::XML(source_file.data)
      doc.xpath('/NessusClientData_v2/Report').each do |report|
        report.xpath('./ReportHost').each do |host|
          @host = source_file.affected_hosts.new
          host.xpath('./HostProperties/tag').each do |tag|
            if tag.attributes['name'].value == 'host-ip'
              @host.host_ip = tag.text.strip
            elsif tag.attributes['name'].value == 'host-fqdn'
              @host.host_fqdn = tag.text.strip
            elsif tag.attributes['name'].value == 'netbios-name'
              @host.netbios_name = tag.text.strip
            elsif tag.attributes['name'].value == 'mac-address'
              @host.mac_address = tag.text.strip
            elsif tag.attributes['name'].value == 'operating-system'
              @host.operating_system = tag.text.strip
            elsif tag.attributes['name'].value == 'os'
              @host.platform = tag.text.strip
            elsif tag.attributes['name'].value == 'HOST_START'
              @last_seen = Time.parse(tag.text).strftime("%Y-%m-%d %I:%M:%S")
            # elsif tag.attributes['name'].value == 'HOST_END'
            #   @host.scan_end = Time.parse(tag.text).strftime("%Y-%m-%d %I:%M:%S")
            end
          end
          # @host.source_file_id = source_file_id
          @host.save
          host.xpath('./ReportItem').each do |item|
            if item.attributes['severity'].value.to_i > 0
              @vuln = @host.vulnerabilities.new
              @vuln.port = item.attributes['port'].value.to_i
              @vuln.service_name = item.attributes['svc_name'].value.strip
              @vuln.protocol = item.attributes['protocol'].value.strip
              @vuln.severity = item.attributes['severity'].value.to_i
              @vuln.plugin_id = item.attributes['pluginID'].value.to_i
              @vuln.vulnerability_name = item.attributes['pluginName'].value.strip
              @vuln.plugin_family = item.attributes['pluginFamily'].value.strip

              @vuln.cvss_score = item.xpath('./cvss_base_score').text.strip
              # TODO : need to loop this element
              @vuln.cve = item.xpath('./cve').text.strip
              @vuln.cpe = item.xpath('./cpe').text.strip
              @vuln.synopsis = item.xpath('./synopsis').text.strip
              @vuln.description = item.xpath('./description').text.strip
              @vuln.solution = item.xpath('./solution').text.strip
              @vuln.output = item.xpath('./plugin_output').text.strip
              @vuln.exploit_available = (item.xpath('./exploit_available').text == "true")? true : false
              @vuln.vulnerability_date = item.xpath('./vulnerability_publication_date').text.strip
              @vuln.patch_date = item.xpath('./patch_publication_date').text.strip
              @vuln.last_seen = @last_seen

              # @vuln.affected_host_id = @host.id
              @vuln.save

              @remedy = @vuln.create_remedy_action!
              # @remedy.save
            end
          end
        end
      end
    end

end

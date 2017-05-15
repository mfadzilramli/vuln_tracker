module VulnerabilitiesHelper

  def get_plugin_id_by_name(obj, vname)
    return Vulnerability.where(affected_host_id: obj, name: vname).pluck(:plugin_id).first
  end
end

module ApplicationHelper
  ###############################################
  # I18n
  ###############################################
  #
  #
  #
  def tview(key, params={}, default_keys=false)
    return t(key, params) if default_keys
    
    # merge default to params 
    params_and_default = {
      :default => t("views.defaults.#{key}", params)
    }
    params_and_default.merge!(params)
    
    # get namespaces
    p = controller_path.split('/').map! { |e| e.downcase }
    a = controller.class.to_s.split('::').map! { |e| e.downcase }
    a.delete_if do |elem|
      !p.include?(elem)
    end
    a = a.join('.')
    a += '.' if a.length > 0
    
    # get view
    t "views.#{a}#{controller_name}.#{key}", params_and_default
  end
end

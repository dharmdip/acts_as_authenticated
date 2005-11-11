class AuthMailerGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, "#{class_name}Mailer", "#{class_name}Observer"

      # Controller, helper, views, and test directories.
      m.directory File.join('app/models', class_path)
      m.directory File.join('app/views', class_path, "#{file_name}_notifier")

      %w( notifier observer ).each do |model_type|
        m.template "#{model_type}.rb", File.join('app/models',
                                             class_path,
                                             "#{file_name}_#{model_type}.rb")
      end

      # Mailer templates
      %w( activation signup_notification ).each do |action|
        m.template "#{action}.rhtml",
                   File.join('app/views', "#{file_name}_notifier", "#{action}.rhtml")
      end
    end
  end
end

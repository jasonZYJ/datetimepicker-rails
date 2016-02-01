require 'securerandom'

module DatetimepickerRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      argument :icon_family, type: :string, :default => "Glyphicon"

      class_option :custom_icons, type: :hash, :default => {
          date: "fa fa-calendar",
          time: "fa fa-clock-o",
          up:   "fa fa-chevron-up",
          down: "fa fa-chevron-down",
          previous: 'fa fa-chevron-left',
          next: 'fa fa-chevron-right',
          today: 'fa fa-crosshairs',
          clear: 'fa fa-trash-o',
          close: 'fa fa-times'
      }

      def source_path
        File.expand_path(File.dirname(__FILE__))
      end

      desc "Creates the Simple form custom fields definition for date, datetime and time pickers."

      def copy_datetime_picker
        template "inputs/datetime_picker_input.rb", "app/inputs/datetime_picker_input.rb" unless
            File.exist?('app/inputs/datetime_picker_input.rb')

        # massage the icons
        gsub_file('app/inputs/datetime_picker_input.rb', 'glyphicon glyphicon-calendar',
                  options[:custom_icons][:date]) unless icon_family == 'Glyphicon'
      end

      def copy_date_picker
        template "inputs/date_picker_input.rb", "app/inputs/date_picker_input.rb" unless
            File.exist?('app/inputs/date_picker_input.rb')

        # massage the icons
        gsub_file('app/inputs/date_picker_input.rb', 'glyphicon glyphicon-calendar',
                  options[:custom_icons][:date]) unless icon_family == 'Glyphicon'
      end

      def copy_time_picker
        template "inputs/time_picker_input.rb", "app/inputs/time_picker_input.rb" unless
            File.exist?('app/inputs/time_picker_input.rb')

        # massage the icons
        gsub_file('app/inputs/time_picker_input.rb', 'glyphicon glyphicon-time',
                  options[:custom_icons][:time]) unless icon_family == 'Glyphicon'
      end

      def copy_datetime_wrapper
        template "wrappers/ranged_datetime_wrapper.rb", "config/initializers/ranged_datetime_wrapper.rb" unless
            File.exist?('config/initializers/ranged_datetime_wrapper.rb')
      end

      # Source the submodule with git://github.com/eonasdan/bootstrap-datetimepicker.git

    private

      def get_icons
        icons = "    icons: {\n"
        icons += "      date: \'#{options[:custom_icons][:date]}\',\n"
        icons += "      time: \'#{options[:custom_icons][:time]}\',\n"
        icons += "      up: \'#{options[:custom_icons][:up]}\',\n"
        icons += "      down: \'#{options[:custom_icons][:down]}\',\n"
        icons += "      previous: \'#{options[:custom_icons][:previous]}\',\n"
        icons += "      next: \'#{options[:custom_icons][:next]}\',\n"
        icons += "      today: \'#{options[:custom_icons][:today]}\',\n"
        icons += "      clear: \'#{options[:custom_icons][:clear]}\',\n"
        icons += "      close: \'#{options[:custom_icons][:close]}\'\n"
        icons += "    }"
      end

    end
  end
end

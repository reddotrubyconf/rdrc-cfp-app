# frozen_string_literal: true

module BootstrapFlashHelper
  BOOTSTRAP_FLASH_CLASSES = {
    success: "alert-success",
    error:   "alert-danger",
    alert:   "alert-warning",
    notice:  "alert-info"
  }.freeze

  def flash_messages
    return if flash.empty?

    messages = flash.map { |type, message| flash_message(type, message) }

    content_tag(:div, class: "container") do
      messages.map { |message| concat(message) }
    end
  end

  private

  def flash_message(type, message)
    content_tag(:div, message, class: "alert #{BOOTSTRAP_FLASH_CLASSES[type.to_sym]}") do
      concat(flash_close_button)
      concat(message)
    end
  end

  def flash_close_button
    content_tag(:button, class: "close", data: { dismiss: "alert" }) do
      content_tag(:span, "", class: "glyphicon glyphicon-remove")
    end
  end
end

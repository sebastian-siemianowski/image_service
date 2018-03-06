# frozen_string_literal: true

# Catch general API roting errors and present as JSON
class ErrorsController < ApplicationController
  def index
    # This exception will be handled by the rescue in the application
    # controller.
    raise ActionController::RoutingError, 'Unknown route'
  end
end

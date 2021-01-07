class DataIntegration::OpenItPotres2020
  class Controller < ApplicationController
    def callback
      puts params.inspect
      render :json => {status: 'approved'}
    end
  end
end
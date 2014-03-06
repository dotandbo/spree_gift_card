Spree::CheckoutController.class_eval do

  durably_decorate :update, mode: 'soft', sha: '50483e9e19c92eb7c13d025ca9594d3855831d36' do
    if @order.update_attributes(object_params)
      fire_event('spree.checkout.update')

      if @order.gift_code.present?
        render :edit and return unless apply_gift_code
      end

      unless @order.next
        flash[:error] = Spree.t(:payment_processing_failed)
        redirect_to checkout_state_path(@order.state) and return
      end

      if @order.completed?
        session[:order_id] = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        redirect_to completion_route
      else
        redirect_to checkout_state_path(@order.state)
      end
    else
      render :edit
    end
  end

end

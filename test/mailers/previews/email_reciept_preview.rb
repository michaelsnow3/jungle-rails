class EmailReceiptPreview < ActionMailer::Preview

  def order_receipt()
    @order = Order.first
    @line_items = @order.line_items
    EmailReceipt.order_receipt(@order.email, @order)
  end

end

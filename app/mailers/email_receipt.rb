class EmailReceipt < ApplicationMailer

  def order_receipt(order)
    @order = order
    @line_items = @order.line_items
    mail(to: @order.email, subject: "Receipt for order #{@order.id}")
  end

end

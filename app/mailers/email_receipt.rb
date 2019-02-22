class EmailReceipt < ApplicationMailer

  def order_receipt(email, order)
    @order = order
    @line_items = @order.line_items
    mail(to: email, subject: "Receipt for order #{order.id}")
  end

end

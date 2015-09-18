module Elmas
  class SalesOrderLine
    include Elmas::Resource
    include Elmas::SharedSalesAttributes

    def base_path
      "salesorder/SalesOrderLines"
    end

    def mandatory_attributes
      [:item, :order_ID]
    end

    def other_attributes
      SHARED_LINE_ATTRIBUTES.inject(
        [
          :amount_FC, :delivery_date, :item_version, :order_number, :unit_price,
          :use_drop_shipment, :VAT_amount
        ],
        :<<
      )
    end
  end
end

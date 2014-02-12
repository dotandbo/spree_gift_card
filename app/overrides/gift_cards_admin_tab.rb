Deface::Override.new(:virtual_path => "spree/admin/shared/_menu",
                     :name => "gift_card_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:gift_cards) %>",
                     :disabled => false)
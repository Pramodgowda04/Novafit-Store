import java.util.List;

import com.fashionstore.dao.OrderItemDAO;
import com.fashionstore.dao.impl.OrderItemDAOImpl;
import com.fashionstore.model.OrderItem;

public class TestOrderItemDAO {

    public static void main(String[] args) {

        OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

        // TEST ORDER ID = 1
        List<OrderItem> items = orderItemDAO.getItemsByOrderId(1);

        if (items != null && !items.isEmpty()) {

            System.out.println("===== ORDER ITEMS =====");

            for (OrderItem item : items) {

                System.out.println("Order Item ID : " + item.getId());
                System.out.println("Order ID      : " + item.getOrderId());
                System.out.println("Product ID    : " + item.getProductId());
                System.out.println("Size          : " + item.getSize());
                System.out.println("Quantity      : " + item.getQuantity());
                System.out.println("Price         : " + item.getPrice());

                System.out.println("--------------------------------");
            }

        } else {

            System.out.println("NO ORDER ITEMS FOUND");
        }
    }
}
import java.util.List;

import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.model.Order;

public class TestOrderDAO {

    public static void main(String[] args) {

        OrderDAO orderDAO = new OrderDAOImpl();

        // TEST USER ID = 1
        List<Order> orders = orderDAO.getOrdersByUserId(1);

        if (orders != null && !orders.isEmpty()) {

            System.out.println("===== ORDER LIST =====");

            for (Order order : orders) {

                System.out.println("Order ID      : " + order.getId());
                System.out.println("User ID       : " + order.getUserId());
                System.out.println("Total Amount  : " + order.getTotalAmount());
                System.out.println("Status        : " + order.getStatus());
                System.out.println("Created At    : " + order.getCreatedAt());

                System.out.println("--------------------------------");
            }

        } else {

            System.out.println("NO ORDERS FOUND");
        }
    }
}
import java.util.List;

import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.model.CartItem;

public class TestCartItemDAO {

    public static void main(String[] args) {

        CartItemDAO cartItemDAO = new CartItemDAOImpl();

        // TEST CART ID = 1
        List<CartItem> items = cartItemDAO.getCartItemsByCartId(1);

        if (items != null && !items.isEmpty()) {

            System.out.println("===== CART ITEMS =====");

            for (CartItem item : items) {

                System.out.println("Cart Item ID : " + item.getId());
                System.out.println("Cart ID      : " + item.getCartId());
                System.out.println("Product ID   : " + item.getProductId());
                System.out.println("Size         : " + item.getSize());
                System.out.println("Quantity     : " + item.getQuantity());

                System.out.println("--------------------------------");
            }

        } else {

            System.out.println("NO CART ITEMS FOUND");
        }
    }
}
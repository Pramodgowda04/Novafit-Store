import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.model.Cart;

public class TestCartDAO {

    public static void main(String[] args) {

        CartDAO cartDAO = new CartDAOImpl();

        // TEST USER ID = 1
        Cart cart = cartDAO.getCartByUserId(1);

        if (cart != null) {

            System.out.println("===== CART DETAILS =====");

            System.out.println("Cart ID     : " + cart.getId());
            System.out.println("User ID     : " + cart.getUserId());
            System.out.println("Created At  : " + cart.getCreatedAt());

        } else {

            System.out.println("NO CART FOUND");
        }
    }
}
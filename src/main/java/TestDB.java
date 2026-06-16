import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;
import java.util.List;

public class TestDB {
    public static void main(String[] args) {
        try {
            ProductDAOImpl dao = new ProductDAOImpl();
            List<Product> products = dao.getProductsByCategory(1);
            System.out.println("Products found: " + products.size());
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}

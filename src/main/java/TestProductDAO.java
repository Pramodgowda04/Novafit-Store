import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

public class TestProductDAO {

    public static void main(String[] args) {

        ProductDAO productDAO = new ProductDAOImpl();

        List<Product> products = productDAO.getAllProducts();

        if (products != null && !products.isEmpty()) {

            System.out.println("===== PRODUCT LIST =====");

            for (Product product : products) {

                System.out.println("Product ID   : " + product.getId());
                System.out.println("Name         : " + product.getName());
                System.out.println("Description  : " + product.getDescription());
                System.out.println("Price        : " + product.getPrice());
                System.out.println("Category ID  : " + product.getCategoryId());
                System.out.println("Image URL    : " + product.getImage());

                System.out.println("--------------------------------");
            }

        } else {

            System.out.println("NO PRODUCTS FOUND");
        }
    }
}
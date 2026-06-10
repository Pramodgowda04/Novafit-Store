import java.util.List;

import com.fashionstore.dao.ProductSizeDAO;
import com.fashionstore.dao.impl.ProductSizeDAOImpl;
import com.fashionstore.model.ProductSize;

public class TestProductSizeDAO {

    public static void main(String[] args) {

        ProductSizeDAO productSizeDAO = new ProductSizeDAOImpl();

        // TEST PRODUCT ID = 1
        List<ProductSize> sizes = productSizeDAO.getSizesByProductId(1);

        if (sizes != null && !sizes.isEmpty()) {

            System.out.println("===== PRODUCT SIZES =====");

            for (ProductSize ps : sizes) {

                System.out.println("Product Size ID : " + ps.getId());
                System.out.println("Product ID      : " + ps.getProductId());
                System.out.println("Size            : " + ps.getSize());
                System.out.println("Stock           : " + ps.getStock());

                System.out.println("--------------------------------");
            }

        } else {

            System.out.println("NO SIZES FOUND");
        }
    }
}
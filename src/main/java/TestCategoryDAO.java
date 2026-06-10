import java.util.List;

import com.fashionstore.dao.CategoryDAO;
import com.fashionstore.dao.impl.CategoryDAOImpl;
import com.fashionstore.model.Category;

public class TestCategoryDAO {

    public static void main(String[] args) {

        CategoryDAO categoryDAO = new CategoryDAOImpl();

        List<Category> categories = categoryDAO.getAllCategories();

        if (categories != null && !categories.isEmpty()) {

            System.out.println("===== CATEGORY LIST =====");

            for (Category category : categories) {

                System.out.println("Category ID   : " + category.getId());
                System.out.println("Category Name : " + category.getCategoryName());

                System.out.println("----------------------------");
            }

        } else {

            System.out.println("NO CATEGORIES FOUND");
        }
    }
}
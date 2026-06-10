import com.fashionstore.dao.UserDAO;
import com.fashionstore.dao.impl.UserDAOImpl;
import com.fashionstore.model.User;

public class TestUserDAO {

    public static void main(String[] args) {

        UserDAO userDAO = new UserDAOImpl();

        User user = userDAO.loginUser(
                "pramod@gmail.com",
                "1234"
        );

        if (user != null) {

            System.out.println("===== LOGIN SUCCESS =====");

            System.out.println("User ID   : " + user.getId());
            System.out.println("Name      : " + user.getName());
            System.out.println("Email     : " + user.getEmail());
            System.out.println("Password  : " + user.getPassword());
            System.out.println("Phone     : " + user.getPhone());
            System.out.println("Address   : " + user.getAddress());

        } else {

            System.out.println("INVALID EMAIL OR PASSWORD");
        }
    }
}
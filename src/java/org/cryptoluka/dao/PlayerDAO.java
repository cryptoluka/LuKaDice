package org.cryptoluka.dao;

/**
 *
 * @author arielsalas
 */
import java.util.List;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.cryptoluka.entity.Player;
import org.cryptoluka.dal.HibernateUtil;

/**
 *
 * @author Ariel Salas
 */
public class PlayerDAO {

    public boolean add(Player a) throws Exception {
        Session sessionA = HibernateUtil.getSessionFactory().openSession();
        sessionA.beginTransaction();
        try {
            sessionA.save(a);
            sessionA.getTransaction().commit();
            sessionA.close();
            return true;
        } catch (Exception e) {
            sessionA.getTransaction().rollback();
            sessionA.close();
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public static List<Player> getList() throws Exception {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            List<Player> lista = (List<Player>) session.createCriteria(Player.class).list();
            session.getTransaction().commit();
            return lista;
        } catch (Exception e) {
            session.getTransaction().rollback();
            session.close();
            System.out.println(e.getMessage());
            throw e;
        } finally {
            session.close();
        }
    }

    public static List<Player> getListActive() throws Exception {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            List<Player> lista = (List<Player>) session.createCriteria(Player.class)
                    .add(Restrictions.eq("status", 1))
                    .list();
            session.getTransaction().commit();
            return lista;
        } catch (Exception e) {
            session.getTransaction().rollback();
            session.close();
            System.out.println(e.getMessage());
            throw e;
        } finally {
            session.close();
        }
    }

    public static List<Player> getListByTipoUsuarioActive(int idTipo) throws Exception {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            List<Player> lista = (List<Player>) session.createCriteria(Player.class)
                    .add(Restrictions.eq("tipousuario.id", idTipo))
                    .add(Restrictions.eq("status", 1))
                    .list();
            session.getTransaction().commit();
            return lista;
        } catch (Exception e) {
            session.getTransaction().rollback();
            session.close();
            System.out.println(e.getMessage());
            throw e;
        } finally {
            session.close();
        }
    }

    public static boolean delete(Player a) throws Exception {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            session.delete(a);
            session.getTransaction().commit();
            session.close();
            return true;
        } catch (Exception e) {
            session.getTransaction().rollback();
            session.close();
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public boolean update(Player a) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            session.update(a);
            session.getTransaction().commit();
            session.close();
            return true;
        } catch (Exception e) {
            session.getTransaction().rollback();
            session.close();
            System.out.println(e.getMessage());
            throw e;
        }
    }

    public Player getById(String id) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();

            Player tmp = (Player) session.createCriteria(Player.class)
                    .add(Restrictions.eq("idplayer", id))
                    .uniqueResult();
            session.getTransaction().commit();
            session.close();
            return tmp;

        } catch (Exception e) {
            System.out.print(e.getMessage());
            session.close();
            throw e;
        }

    }

    public static Player getByUsername(String user) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();

            Player tmp = (Player) session.createCriteria(Player.class)
                    .add(Restrictions.eq("username", user))
                    .add(Restrictions.eq("status", 1))
                    .uniqueResult();
            session.getTransaction().commit();
            session.close();
            return tmp;

        } catch (Exception e) {
            System.out.print(e.getMessage());
            session.close();
            throw e;
        }

    }
    
    

    public Player getByCorreoActive(String correo) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();

            Player tmp = (Player) session.createCriteria(Player.class)
                    .add(Restrictions.eq("email", correo))
                    .uniqueResult();
            session.getTransaction().commit();
            session.close();
            return tmp;

        } catch (Exception e) {
            System.out.print(e.getMessage());
            session.close();
            throw e;
        }
    } 
}

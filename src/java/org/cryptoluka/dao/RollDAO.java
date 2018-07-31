package org.cryptoluka.dao;

/**
 *
 * @author arielsalas
 */
import java.util.List;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.cryptoluka.dal.HibernateUtil;
import org.cryptoluka.entity.Rollhistory;
import org.hibernate.criterion.Order;

/**
 *
 * @author Ariel Salas
 */
public class RollDAO {

    public boolean add(Rollhistory a) throws Exception {
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

    public static List<Rollhistory> getList() throws Exception {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            List<Rollhistory> lista = (List<Rollhistory>) session.createCriteria(Rollhistory.class).list();
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

    public static List<Rollhistory> getListActive() throws Exception {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            List<Rollhistory> lista = (List<Rollhistory>) session.createCriteria(Rollhistory.class)
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
    
    public List<Rollhistory> getLast7Bets() throws Exception {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            List<Rollhistory> lista = (List<Rollhistory>) session.createCriteria(Rollhistory.class)
                    .setMaxResults(7)
                    .addOrder(Order.desc("creationtime"))
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

   

    public boolean delete(Rollhistory a) throws Exception {

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

    public boolean update(Rollhistory a) throws Exception {
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

    public Rollhistory getById(String id) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();

            Rollhistory tmp = (Rollhistory) session.createCriteria(Rollhistory.class)
                    .add(Restrictions.eq("idgame", id))
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

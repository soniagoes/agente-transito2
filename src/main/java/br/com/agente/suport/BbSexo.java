package br.com.agente.suport;

import br.com.agente.model.dao.HibernateDAO;
import br.com.agente.model.dao.InterfaceDAO;
import br.com.agente.model.entities.Sexo;
import br.com.agente.util.FacesContextUtil;
import java.io.Serializable;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

@ManagedBean(name="bbSexo")
@RequestScoped
public class BbSexo  implements Serializable {

    private static final long serialVersionUID = 1L;
    
    public List<Sexo> getSexos(){
        InterfaceDAO<Sexo> sexoDAO = new HibernateDAO<Sexo>(Sexo.class, FacesContextUtil.getRequestSession());
        return sexoDAO.getEntities();
    }
    
}

package br.com.agente.controller;


import br.com.agente.model.dao.HibernateDAO;
import br.com.agente.model.dao.InterfaceDAO;
import br.com.agente.model.entities.Estado;
import br.com.agente.util.FacesContextUtil;
import java.io.Serializable;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

@ManagedBean(name = "mbEstado")
@RequestScoped
public class MbEstado implements Serializable {
    private static final long serialVersionUID = 1L;
    private Estado estado = new Estado();
    private List<Estado> estados;
    public MbEstado(){
    }
    
    private InterfaceDAO<Estado> estadoDAO(){
        InterfaceDAO<Estado> estadoDAO = new HibernateDAO<Estado>(Estado.class, FacesContextUtil.getRequestSession());
        return estadoDAO;    
    }

    public String limpEstado(){
    estado = new Estado();
    return editEstado();

}
    public String editEstado(){
    return "/restrict/cadastrarestado.faces";
}
public String addEstado(){
if (estado.getIdEstado() == null  || estado.getIdEstado() == 0){
    insertEstado();
}else{
    updateEstado();
}
    limpEstado();
    return null;

}
    private void insertEstado(){
        estadoDAO().save(estado);
        FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Gravação Efetuada com Sucesso!", ""));
        
    }
    public void updateEstado(){
        estadoDAO().update(estado);
        FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Atualização efetuada com sucesso.", ""));
        
    }
     public void deleteEstado(){
        estadoDAO().remove(estado);        
    }
    
    public List<Estado> getEstados(){
        estados = estadoDAO().getEntities();
        return estados;
    }
    public void setEstados(List<Estado> estados){
        this.estados = estados;
    }
    public Estado getEstado(){
        return estado;
        
    }
    public void setEstado(Estado estado){
        this.estado = estado;
    }
}
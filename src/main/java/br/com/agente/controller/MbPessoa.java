package br.com.agente.controller;

import br.com.agente.conversores.ConverterSHA1;
import br.com.agente.model.dao.HibernateDAO;
import br.com.agente.model.dao.InterfaceDAO;
import br.com.agente.model.entities.Endereco;
import br.com.agente.model.entities.Pessoa;
import br.com.agente.util.FacesContextUtil;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
/*vamos usar o wizard ao inves do tabview, para que seja obrigatorio o preenchimento das duas abas
antes de salvar. Teremos uma aba pessoa e outra endereço dessa pessoa
http://www.primefaces.org/showcase/ui/panel/wizard.xhtml
*/
@ManagedBean
@SessionScoped
public class MbPessoa implements Serializable {

    private static final long serialVersionUID = 1L;
    private String confereSenha;
    private Pessoa pessoa = new Pessoa();
    private Endereco endereco = new Endereco();
    private List<Pessoa> pessoas;
    private List<Endereco> enderecos;
//construtor vazio
    public MbPessoa() {
    }
/*criar os daos para endereço e para pessoa*/
    private InterfaceDAO<Pessoa> pessoaDAO() {
        InterfaceDAO<Pessoa> pessoaDAO = new HibernateDAO<Pessoa>(Pessoa.class, FacesContextUtil.getRequestSession());
        return pessoaDAO; //acessa a tabela pessoa
    }

    private InterfaceDAO<Endereco> enderecoDAO() {
        InterfaceDAO<Endereco> enderecoDAO = new HibernateDAO<Endereco>(Endereco.class, FacesContextUtil.getRequestSession());
        return enderecoDAO; //acessa a tabela endereco
    }

    public String limpPessoa() {
        pessoa = new Pessoa();
        endereco = new Endereco();
        return editPessoa();
    }

    public String editPessoa() {
        return "/restrict/cadastrarpessoa.faces";
    }

    public String addPessoa() {
        Date date = new Date(); //pega a data do cadastro
        if (pessoa.getIdPessoa() == null || pessoa.getIdPessoa() == 0) {
            pessoa.setDataDeCadastro(date);//passa a data de cadastro da pessoa
            insertPessoa();
        } else {
            updatePessoa();
        }

        return null;
    }

    private void insertPessoa() {
        //converte a senha e depois cifra ela
        pessoa.setSenha(ConverterSHA1.cipher(pessoa.getSenha()));
        
        if (pessoa.getSenha() == null ? confereSenha == null : pessoa.getSenha().equals(ConverterSHA1.cipher(confereSenha))) {
            pessoa.setPermissao("ROLE_ADMIN");//por padrao o spring security usa esse ROLE_ADMIN mas não é recomendado
            pessoaDAO().save(pessoa);
            endereco.setPessoa(pessoa);
            enderecoDAO().save(endereco);
            FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage(FacesMessage.SEVERITY_INFO, "Gravação efetuada com sucesso", ""));
        } else {
            FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage(FacesMessage.SEVERITY_INFO, "As senhas não conferem.", ""));
        }
    }

    private void updatePessoa() {
        pessoaDAO().update(pessoa);
        enderecoDAO().update(endereco);//não precisa setar id pq se está editando pressupoe-se que já esta com id preenchido
        FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Atualização efetuada com sucesso", ""));
    }

    public String deletePessoa() {
        pessoaDAO().remove(pessoa);
        enderecoDAO().remove(endereco);
        FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_INFO, "Registro excluído com sucesso", ""));
        return null;
    }

    public List<Pessoa> getPessoas() {
        pessoas = pessoaDAO().getEntities();
        return pessoas;
    }

    public void setPessoas(List<Pessoa> pessoas) {
        this.pessoas = pessoas;
    }

    public List<Endereco> getEnderecos() {
        enderecos = enderecoDAO().getEntities();
        return enderecos;
    }

    public void setEnderecos(List<Endereco> enderecos) {
        this.enderecos = enderecos;
    }

    public Pessoa getPessoa() {
        return pessoa;
    }

    public void setPessoa(Pessoa pessoa) {
        this.pessoa = pessoa;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public String getConfereSenha() {
        return confereSenha;
    }

    public void setConfereSenha(String confereSenha) {
        this.confereSenha = confereSenha;
    }
}

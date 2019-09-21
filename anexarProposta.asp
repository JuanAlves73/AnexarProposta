<!--#include file="../includes/funcao_geral.asp"-->
<!--#include file="../includes/constantes_SQL.asp"-->

<%
  COD_CLIENTE_PROSPER   = Request.QueryString("p")
  id                = Request.QueryString("id")

  set objConn = nothing
  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open ConnSQL

   cont = 0 
  if id <> ""  then

      SQL = ""
      SQL = SQL & " SELECT * "
      SQL = SQL & " FROM CLIENTE_PROSPER_HISTORICO                             "
        
      
      

     set rsProposta = objConn.Execute(SQL)
    
     if not rsProposta.eof then
       cbComprovante = " <table class='tableComprovante'> "  
                                               
       while not rsProposta.eof 
                                      
           p = rsProposta("cod_cliente_prosper")
           id = rsProposta("id")
           codC = rsProposta("cod_cliente_prosper")
           tipo = rsProposta("tipo")
           caminho =rsProposta("caminho_arquivo")
           dRegistro = rsProposta("data_registro")
           url = rsProposta("url_acesso_bid")
           login = rsProposta("login_bid")
           senha = rsProposta("senha_bid")
           dInclusao = rsProposta("data_inclusao")
           codF = rsProposta("cod_funcionario")
           observacao = rsProposta("observacao")
    

              ' cont = cont + 1
               if not isNull(link) and trim(link) <> "" then
                cbComprovante = cbComprovante & " <tr>                                           "
                cbComprovante = cbComprovante & " <td align='center'><a href='"&link&"'>Comprovante "&id&" </a></td>  "
                cbComprovante = cbComprovante & " <td align='center'>"&data_registro&"</td>  "
                cbComprovante = cbComprovante & " <td align='center'><button onclick=deleteAnexo('"&trim(id)&"') type='button' class='btn-xs btn-danger'>Excluir</button></td> "
                cbComprovante = cbComprovante & " </tr>                                          "
               end if

              lvIndComprovante      = rsProposta("CAMINHO_ARQUIVO")  

           rsProposta.movenext
       wend
      cbComprovante = cbComprovante &  " </table> "  
     end if 
  end if
  
%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en">
<head>
    <title>Anexar Proposta</title>
    <link rel="stylesheet" href="../stylescript/leaderstyle.css" />
    <link rel="stylesheet" href="../stylescript/bootstrap.min.css">
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.10/jquery.mask.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type="../image/png" href="../images/logo3.jpg"/>
    <script type="text/javascript" >
        //LoadPage
        window.onload = function () {
            document.getElementById("loading").style.display = "none"
        }

        function enviardados() {
            if (document.dados.valorComprovante.value == "") {
                alert("Preencha campo Comprovante!");
                document.dados.valorComprovante.focus();
                return false;
            }
        }
        
                    success: function (result) {
                        document.getElementById("resp").innerHTML = "<div class='alert alert-success' style='text-align:center;'><strong>Sucesso!</strong> Documento foi excluído..</div>"
                        setTimeout(function () {
                            // wait for 5 secs(2)
                            location.reload(); // then reload the page.(3)
                        }, 500);
                    },
                    error: function (xhr) {
                        document.getElementById("resp").innerHTML = "Erro :" + xhr.status + " <br> Informação :" + xhr.responseText;
                    },
                    complete: function () {
                        $('#loading').hide();
                    }

                });

            } else {
                alert(" Ação cancelada ! ");
                $('#loading').hide();
                return false;
            }

        }
    </script>

</head>

<body>


<div class="container-full">
    <div class="tituloModulo">&emsp;Anexar Proposta</div>
    <div id="resp" style="position:absolute;width:100%; z-index:9999999; ">
    </div>
    <br />
    <div align="center">

         <form method='post' encType='multipart/form-data' action='incluiAnexo.asp' name="dados" onSubmit="return enviardados();">   
            <%
                sql = "select * from CLIENTE_PROSPER_HISTORICO  "
                    set rsProposta = objConn.Execute(sql)


                    if not rsProposta.eof then

                     p = rsProposta("cod_cliente_prosper")
                     id = rsProposta("id")                  
    
                    end if
             %>
             
             <!--<input type='hidden' name='cont' value="<%=cont%>" />--> 
            <input type="hidden" name='id' value="<%=id%>" />
            <input type='hidden' name='p' value="<%=COD_CLIENTE_PROSPER%>" />                                       
            <div class="form-group" style="width:20%;">   
                <label for='selecao-arquivo' class='UploadComprovante'>Selecionar um Arquivo</label>  
                <span id='file-name'></span>          
		        <input style="display:none;" id='selecao-arquivo' type='File' name='File1'> 
		        <input type='Submit' value='Upload'>    
                
            </div>                            
        </form>
        <hr />
     </div>

    <div align="center">
    <%=cbComprovante%>
    </div>
</div>
<script type="text/javascript">
    var $input = document.getElementById('selecao-arquivo'),
        $fileName = document.getElementById('file-name');

    $input.addEventListener('change', function () {
        $fileName.textContent = this.value;
    });

</script> 
</body>
</html>
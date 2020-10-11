# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Noxi.Repo.insert!(%Noxi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Companys and products

Noxi.Repo.insert(
  Noxi.UserSchema.changeset(
    %Noxi.UserSchema{}, %{
      name: "Thiago Boeker",
      email: "thiagoboeker7k@gmail.com",
      credits: 1000000000
    }
  )
)

Noxi.Repo.insert(
  Noxi.CompanySchema.changeset(
  %Noxi.CompanySchema{},
    %{
      name: "King Burguer",
      url_image: "https://image.freepik.com/free-vector/burger-king-logo_22110-30.jpg",
      products: [
        %{
          name: "X-King Burguer",
          category: "TODOS,LANCHES",
          url_image: "https://cursopalavramagica.com.br/wp-content/uploads/sites/116/2017/09/hamb%C3%BArguer-caseiro-9.jpg",
          price: 500,
          points: 50,
          buy: 500
        },
        %{
          category: "TODOS,LANCHES",
          name: "X-Salada King",
          url_image: "https://img3.stockfresh.com/files/o/ozaiachin/m/64/2811711_stock-photo-big-hamburger-isolated-on-white.jpg",
          price: 750,
          points: 50,
          buy: 750
        },
      ]
    })
)

Noxi.Repo.insert(
  Noxi.CompanySchema.changeset(
  %Noxi.CompanySchema{},
    %{
      name: "Giraffas",
      url_image: "https://static-images.ifood.com.br/image/upload//logosgde/c541d942-308d-478f-859d-8ea04c01589c/202001301149_mDlZ_i.jpg",
      products: [
        %{
          name: "Açai do Giraffas",
          category: "TODOS,MERCADO,LANCHES",
          url_image: "https://static.deliverymuch.com.br/images/products/57cc5de22f6c1.jpg",
          price: 1000,
          points: 100,
          buy: 1100
        },
        %{
          name: "Combo Batata",
          category: "TODOS,LANCHES",
          url_image: "https://a-static.mlcdn.com.br/1500x1500/kit-300-caixinhas-batata-frita-300-fritas-delivery-verde-pdv-print/pdvprint/kit300fritas300fritasdeliveryverde/4cb01f77c444cc6f6ab84a2d931f2e0b.jpg",
          price: 750,
          points: 70,
          buy: 1100
        },
        %{
          category: "TODOS,MERCADO",
          name: "Frutas e Legumes",
          url_image: "https://s1.1zoom.me/big0/22/Salads_Fruit_Raisin_Bananas_White_background_547343_1260x1024.jpg",
          price: 750,
          points: 70,
          buy: 1100
        }
      ]
    })
)

Noxi.Repo.insert(
  Noxi.CompanySchema.changeset(
  %Noxi.CompanySchema{},
    %{
      name: "Oticas Diniz",
      url_image: "https://yt3.ggpht.com/a/AATXAJyrOXNcqMzdgnE1ynn8WJqYlktAtEB0XIrlD9sNwA=s900-c-k-c0x00ffffff-no-rj",
      products: [
        %{
          category: "TODOS,OTICAS",
          name: "Oculos Mergulhados",
          url_image: "https://images-americanas.b2w.io/produtos/01/00/img/51094/9/51094957_1GG.jpg",
          price: 95000,
          points: 150,
          buy: 110000
        }
      ]
    })
)

defmodule Noxi.DAO do
  @moduledoc """
  Modulo de CRUD basico, todas as funcoes definidas aqui seram escritas no modulo que invocar `use Noxi.DAO`

  A macro `__using__`, espera um schema pre-definido todas as funcoes podem ser reescritas inplace pelo modulo
  que invoca a macro.
  """

  alias Noxi.Repo
  import Ecto.Query

  def build_fragments(conditions) when is_list(conditions) do
    Enum.reduce(conditions, dynamic(true), fn condition, acc ->
      dynamic([p], ^acc and ^condition)
    end)
  end

  @doc """
  Retorna dinamicamente os filtros do Model baseado nos parametros passados
  """
  def get_filters(module, params) do
    with true <- valid_filters?(module, params) do
      filters =
        module.__info__(:functions)
        |> Enum.map(fn func -> transform_module_func(func) end)
        |> Enum.filter(fn func -> filter_module_func(func) end)
        |> Enum.flat_map(fn func -> get_valid_func(func, params) end)
        |> Enum.map(fn func -> get_filter_from_module(module, func, params) end)

      {:ok, filters}
    else
      v ->
        IO.inspect v 
        {:error, :invalid_parameters}
    end
  end

  # Após identificar a funcao de filtro, aplica a funcao e retorna o filtro
  defp get_filter_from_module(module, func, params) do
    apply(module, func, [params])
  end

  # Transforma nome de funcao em String
  defp transform_module_func({func, _arity}) do
    Atom.to_string(func)
  end

  # Identifica fucoes de filtro que terminam com "_filter"
  defp filter_module_func(func) do
    String.ends_with?(func, "_filter")
  end

  defp valid_filters?(module, params) do
    # Retira as keys "page" e "page_size" responsaveis pela paginacao
    keys =
      params
      |> Map.keys()
      |> Enum.filter(fn key -> key != "page" and key != "page_size" end)

    # retira o "_filter" de cada nom
    funcs =
      module.__info__(:functions)
      |> Enum.map(fn func -> transform_module_func(func) end)
      |> Enum.filter(fn func -> filter_module_func(func) end)
      |> Enum.map(fn func -> func_name(func) end)

    # Checa se todas as keys estao presentes como funcoes
    Enum.all?(keys, fn key -> Enum.any?(funcs, fn func -> key == func end) end)
  end

  # Retira o "_filter" do final do nome de funcao
  defp func_name(func) do
    func
    |> String.split("_")
    |> Enum.drop(-1)
    |> Enum.join("_")
  end

  # Checa se o parametro contem as keys para invocar as funcoes referentes no modulo
  # Por exemplo, checa se params tem a key "name" se o modulo tem a funcao name_filter
  defp get_valid_func(func, params) do
    case Map.has_key?(params, func_name(func)) do
      true -> [String.to_atom(func)]
      _ -> []
    end
  end

  @doc """
  Funcao que retorna multiplos resultados do schema passado.

  Lembrando que para abrir chaves estrangeiras, todos os preloads devem ser definidos antes pelo schema passado
  ou seja, para abrir todos os States com as suas cidade, deve ser
  `State |> preload(:cities) |> Noxi.DAO.index([], params)`, dessa forma cada estado tera uma chave cities com um array
  de cidades e sera filtrado pelas condicoes passadas no segundo argumento.
  """
  def index(schema, {:ok, filters}, params) do
    try do
      schema
      |> select([u], u)
      |> where(^build_fragments(filters))
      |> Repo.paginate(params)
    rescue
      _ -> {:error, :invalid_parameters}
    end
  end

  def index(_schema, {:error, :invalid_parameters} = error, _params), do: error

  @doc """
  Funcao que cria um registro no banco de dados do Schema passado.

  Na macro de `use Noxi.DAO, Schema`, os parametros schema e changeset sao passados automaticamente.
  Gerando uma funcao que espera apenas `params` como parametro.
  """
  def create(schema, changeset, params \\ %{}) do
    schema.changeset(changeset, params)
    |> Repo.insert()
  end

  @doc """
  Funcao que retorna um unico registro filtrado por ID.

  Originalmente `Noxi.Repo.get/2` retorna nil ou uma instancia do schema passado, mas para auxiliar no uso
  de pattern matching foram adicionados `:empty` e `{:ok, %Ecto.Schema.t}`.
  """
  def show(schema, id) do
    case Repo.get(schema, id) do
      nil -> :empty
      v -> {:ok, v}
    end
  end

  @doc """
  Retorna registros baseados em parametros variados
  """
  def get_by(schema, params) do
    case Repo.get_by(schema, params) do
      nil -> :empty
      v -> {:ok, v}
    end
  end

  @doc """
  Funcao que atualiza um registro no banco.

  Espera um `%Ecto.Changeset{}` com uma chave id.
  """
  def update(schema, changeset, params \\ %{}) do
    schema.changeset(changeset, params)
    |> Repo.update()
  end

  @doc """
  Funcao que deleta um registro do banco.

  Espera um `%Ecto.Changeset{}` com uma chave id.
  """
  def delete(changeset) do
    Repo.delete(changeset)
  end

  defmacro __using__(schema: schema) do
    quote do
      @doc false
      def get_schema() do
        unquote(schema)
      end

      @doc false
      def index(sc, params) do
        Noxi.DAO.index(sc, Noxi.DAO.get_filters(__MODULE__, params), params)
      end

      @doc false
      def create(params) do
        Noxi.DAO.create(unquote(schema), %unquote(schema){}, params)
      end

      @doc false
      def update(changeset, params) do
        Noxi.DAO.update(unquote(schema), changeset, params)
      end

      @doc false
      def delete(changeset) do
        Noxi.DAO.delete(changeset)
      end

      @doc false
      def show(id) do
        Noxi.DAO.show(unquote(schema), id)
      end

      @doc false
      def get_by(params) do
        Noxi.DAO.get_by(unquote(schema), params)
      end

      defoverridable index: 2
      defoverridable create: 1
      defoverridable update: 2
      defoverridable delete: 1
      defoverridable show: 1
      defoverridable get_by: 1
    end
  end
end

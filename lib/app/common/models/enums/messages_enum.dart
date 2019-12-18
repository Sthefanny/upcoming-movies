enum MessagesEnum {
  TIMEOUT_EXCEPTION,
  GENERAL_EXCEPTION,
  NO_INTERNET_EXCEPTION,
}

const Map<MessagesEnum, String> MessagesEnumDescription = {
  MessagesEnum.TIMEOUT_EXCEPTION: "Tempo excedido ao tentar acessar a api. Tente novamente mais tarde.",
  MessagesEnum.GENERAL_EXCEPTION: "Erro ao tentar acessar a api. Tente novamente mais tarde.",
  MessagesEnum.NO_INTERNET_EXCEPTION: "Verifique sua conexão com a internet.",
};

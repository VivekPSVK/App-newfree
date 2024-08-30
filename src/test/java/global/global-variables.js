var globalState = {
  categoryId: null,
  accessToken: null
};

function setCategoryId(id) {
  globalState.categoryId = id;
}

function getCategoryId() {
  return globalState.categoryId;
}

function setAccessToken(token) {
  globalState.accessToken = token;
}

function getAccessToken() {
  return globalState.accessToken;
}

module.exports = {
  setCategoryId: setCategoryId,
  getCategoryId: getCategoryId,
  setProdcutId: setProdcutId,
  getProductId: getProductId,
  setCouponId: setCouponId,
  getCouponId: getCouponId,
  setAccessToken: setAccessToken,
  getAccessToken: getAccessToken
};
package com.wpdrc.pojo;

public class OrderDetail {
    private Integer id;
    private Integer orderId;
    private Integer productId;
    private Float productNum;
    private String productName;
    private Float productPrice;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Float productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Float getProductNum() {
        return productNum;
    }

    public void setProductNum(Float productNum) {
        this.productNum = productNum;
    }
}

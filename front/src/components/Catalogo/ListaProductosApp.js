import React, { useState, useEffect } from "react";
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { Card, Button } from 'react-bootstrap';
import { toast, ToastContainer } from "react-toastify";

import "./ListaProductos.css";

function ListaProductosApp() {
    const savedCart = JSON.parse(localStorage.getItem("carrito")) || [];
    const [cart, setCart] = useState(savedCart); // Productos en el carrito
    const [productos, setProductos] = useState([]);
    const navigate = useNavigate();

    const addToCart = (producto) => {
        setCart((prevCart) => [...prevCart, producto]);
    };

    const verDetalles = (idProducto) => {
        navigate(`/producto/${idProducto}`); // Redirige a la página de detalles con el ID del producto
    };

    const cargarProductos = async () => {
        try {
          const response = await axios.get("http://localhost:8080/producto/");
          setProductos(response.data);
        } catch (error) {
          console.error("Error al cargar productos:", error);
          toast.error("Ocurrió un error al cargar los productos");
        }
    };

    useEffect(() => {
        cargarProductos();
    }, []);

    return (
        <>
            <div id="product-slider" className="product-slider">
                {/* Muestra un mensaje de carga si no hay productos */}
                {productos.length === 0 ? (
                <p>Cargando productos...</p>
                ) : (
                // Mapea los productos y crea una tarjeta para cada uno
                productos.map((product) => (
                    <div className="product-card" key={product.id}>
                        <Card style={{ width: "18rem" }}>
                            {/* Imagen del producto, asegurando la ruta correcta */}
                            <Card.Img
                            variant="top"
                            src={`http://localhost:8080/producto/images/${product.imgProducto}`}
                            />

                        <Card.Body>
                            <Card.Title>{product.nombreProducto}</Card.Title>
                            {/* Nombre del producto */}
                            <Card.Text>
                                <strong>Precio:</strong>{" "}
                                {new Intl.NumberFormat("es-CR", {
                                style: "currency",
                                currency: "CRC",
                                minimumFractionDigits: 0,
                                }).format(product.montoPrecioProducto)}
                            </Card.Text>
                            {/* Precio del producto */}
                            {/*  Redirige al detalle del producto */}
                            <div>  
                            {/* <Button variant="primary" onClick={()=> navigate(`/producto/${product.idProducto}`)}>Ver Producto</Button>{" "}*/}
                                <Button onClick={() => verDetalles(product.idProducto)}>Ver detalles</Button>
                                <Button
                                    variant="success"
                                    size="sm"
                                    className="float-end"
                                    onClick={() => addToCart(product)}
                                >
                                Agregar
                                </Button>
                            </div>
                            {/* Botón para ver más detalles */}
                            </Card.Body>
                        </Card>
                    </div>
                ))
                )}
            </div>
        </>
    );
}

export default ListaProductosApp;
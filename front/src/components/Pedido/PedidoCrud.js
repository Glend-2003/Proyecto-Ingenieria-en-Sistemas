import React from 'react';
import { Container, Row, Col, Card } from 'react-bootstrap';

function Pedido() {
  return (
    <Container className="py-5">
      <Row className="justify-content-center">
        <Col md={8}>
          <Card>
            <Card.Header as="h2" className="text-center bg-primary text-white">
              Finalizar Pedido
            </Card.Header>
            <Card.Body>
              <h3 className="mb-4 text-center">¡Hola Mundo desde la página de Pedido!</h3>
              <p className="text-center">
                Aquí podrás completar la información para finalizar tu compra.
              </p>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
}

export default Pedido;
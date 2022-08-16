createcertificatesForOrg1() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.org1.solulab.com --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-solulab-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-solulab-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-solulab-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-solulab-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  fabric-ca-client register --caname ca.org1.solulab.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  echo
  echo "Register peer1"
  echo
  fabric-ca-client register --caname ca.org1.solulab.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

   echo
  echo "Register peer2"
  echo
  fabric-ca-client register --caname ca.org1.solulab.com --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.org1.solulab.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.org1.solulab.com --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/msp --csr.hosts peer0.org1.solulab.com --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls --enrollment.profile tls --csr.hosts peer0.org1.solulab.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/tlsca
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/tlsca/tlsca.org1.solulab.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/ca
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer0.org1.solulab.com/msp/cacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/ca/ca.org1.solulab.com-cert.pem

  # ------------------------------------------------------------------------------------------------

  # Peer1

  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/msp --csr.hosts peer1.org1.solulab.com --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/tls --enrollment.profile tls --csr.hosts peer1.org1.solulab.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer1.org1.solulab.com/tls/server.key

  # -------------------------------------------------------------------------------------------------- # --------------------------------------------------------------------------------------------------
# Peer2

  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com

  echo
  echo "## Generate the peer2 msp"
  echo
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/msp --csr.hosts peer2.org1.solulab.com --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/msp/config.yaml

  echo
  echo "## Generate the peer2-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/tls --enrollment.profile tls --csr.hosts Peer2.org1.solulab.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/Peer2.org1.solulab.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/peers/peer2.org1.solulab.com/tls/server.key



# --------------------------------------------------------------------------------------------------

  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/users
  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/users/User1@org1.solulab.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/users/User1@org1.solulab.com/msp --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  mkdir -p crypto-config-ca/peerOrganizations/org1.solulab.com/users/Admin@org1.solulab.com

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca.org1.solulab.com -M ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/users/Admin@org1.solulab.com/msp --tls.certfiles ${PWD}/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org1.solulab.com/users/Admin@org1.solulab.com/msp/config.yaml

}


createCertificateForOrg2() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p /crypto-config-ca/peerOrganizations/org2.optimize.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.org2.optimize.com --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-optimize-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-optimize-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-optimize-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-optimize-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
   
  fabric-ca-client register --caname ca.org2.optimize.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  echo
  echo "Register peer1"
  echo
   
  fabric-ca-client register --caname ca.org2.optimize.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   
  echo
  echo "Register peer2"
  echo
   
  fabric-ca-client register --caname ca.org2.optimize.com --id.name peer2 --id.secret peer2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem



  echo
  echo "Register user"
  echo
   
  fabric-ca-client register --caname ca.org2.optimize.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  echo
  echo "Register the org admin"
  echo
   
  fabric-ca-client register --caname ca.org2.optimize.com --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  mkdir -p crypto-config-ca/peerOrganizations/org2.optimize.com/peers
  mkdir -p crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/msp --csr.hosts peer0.org2.optimize.com --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls --enrollment.profile tls --csr.hosts peer0.org2.optimize.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/tlsca
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/tlsca/tlsca.org2.optimize.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/ca
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer0.org2.optimize.com/msp/cacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/ca/ca.org2.optimize.com-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo
   
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/msp --csr.hosts peer1.org2.optimize.com --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/tls --enrollment.profile tls --csr.hosts peer1.org2.optimize.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer1.org2.optimize.com/tls/server.key
  # -----------------------------------------------------------------------------------


# --------------------------------------------------------------------------------
  #  Peer 2
  echo
  echo "## Generate the peer2 msp"
  echo
   
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/msp --csr.hosts peer2.org2.optimize.com --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer2:peer2pw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/tls --enrollment.profile tls --csr.hosts peer2.org2.optimize.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/peers/peer2.org2.optimize.com/tls/server.key
  # -----------------------------------------------------------------------------------


  mkdir -p crypto-config-ca/peerOrganizations/org2.optimize.com/users
  mkdir -p crypto-config-ca/peerOrganizations/org2.optimize.com/users/User1@org2.optimize.com

  echo
  echo "## Generate the user msp"
  echo
   
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/users/User1@org2.optimize.com/msp --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  mkdir -p crypto-config-ca/peerOrganizations/org2.optimize.com/users/Admin@org2.optimize.com

  echo
  echo "## Generate the org admin msp"
  echo
   
  fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca.org2.optimize.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/users/Admin@org2.optimize.com/msp --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org2.optimize.com/users/Admin@org2.optimize.com/msp/config.yaml

}

createCretificateForOrderer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p crypto-config-ca/ordererOrganizations/example.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config-ca/ordererOrganizations/example.com

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config-ca/ordererOrganizations/example.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

 

  echo
  echo "Register the orderer admin"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  mkdir -p crypto-config-ca/ordererOrganizations/example.com/orderers
  # mkdir -p crypto-config-ca/ordererOrganizations/example.com/orderers/example.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com

  echo
  echo "## Generate the orderer msp"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/ordererOrganizations/example.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # -----------------------------------------------------------------------
 
  # ---------------------------------------------------------------------------
 
  # ---------------------------------------------------------------------------

  mkdir -p crypto-config-ca/ordererOrganizations/example.com/users
  mkdir -p crypto-config-ca/ordererOrganizations/example.com/users/Admin@example.com

  echo
  echo "## Generate the admin msp"
  echo
   
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config-ca/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml

}


sudo rm -rf crypto-config-ca/*
# sudo rm -rf fabric-ca/*
createcertificatesForOrg1
createCertificateForOrg2
createCretificateForOrderer
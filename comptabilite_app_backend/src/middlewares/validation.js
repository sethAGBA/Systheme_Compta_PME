// const validateInvoice = (req, res, next) => {
//     const { numero, type, clientNom, rccm, adresseFournisseur, lignes } = req.body;
  
//     if (!numero || !type || !clientNom || !rccm || !adresseFournisseur || !lignes || !Array.isArray(lignes)) {
//       return res.status(400).json({ message: 'Champs obligatoires manquants' });
//     }
  
//     if (!/^[A-Z]{2}-[A-Z]{3}-\d{4}-\d+$/.test(rccm)) {
//       return res.status(400).json({ message: 'RCCM invalide (ex. SN-DKR-2025-123)' });
//     }
  
//     if (lignes.some(ligne => !ligne.description || ligne.quantite <= 0 || ligne.prixUnitaire <= 0)) {
//       return res.status(400).json({ message: 'Lignes invalides' });
//     }
  
//     next();
//   };
  
//   module.exports = {
//     invoice: validateInvoice,
//   };


// const validateInvoice = (req, res, next) => {
//     const { numero, type, clientNom, clientRccm, adresseFournisseur, lignes, devise } = req.body;
  
//     // Vérification des champs obligatoires
//     if (!numero || !type || !clientNom || !clientRccm || !adresseFournisseur || !lignes || !Array.isArray(lignes)) {
//       return res.status(400).json({ message: 'Champs obligatoires manquants : numéro, type, clientNom, clientRccm, adresseFournisseur, ou lignes' });
//     }
  
//     // Validation du RCCM avec la nouvelle regex
//      const rccmRegex = /^(RC|RM)\/[A-Z]{2}\/[A-Z]{3}\/\d{4}\/[A-Z]\d{4,5}$/;
//     if (!rccmRegex.test(clientRccm)) {
//       return res.status(400).json({ message: 'RCCM invalide (ex. RC/TG/LOM/2023/A00987)' });
//     }
  
//     // Validation des lignes
//     if (lignes.length === 0 || lignes.some(ligne => !ligne.description || ligne.description.trim() === '' || ligne.quantite <= 0 || ligne.prixUnitaire <= 0)) {
//       return res.status(400).json({ message: 'Les lignes doivent avoir une description non vide, une quantité positive et un prix unitaire positif' });
//     }
  
//     // Vérification de la devise (par défaut XOF)
//     if (devise && devise !== 'XOF') {
//       return res.status(400).json({ message: 'Devise non prise en charge (seul XOF est autorisé)' });
//     }
  
//     next();
//   };
  
//   module.exports = {
//     invoice: validateInvoice,
//   };

// const validateInvoice = (req, res, next) => {
//     const { numero, type, clientNom, clientRccm, adresseFournisseur, lignes, devise } = req.body;
  
//     // Vérification des champs obligatoires
//     if (!numero || !type || !clientNom || !clientRccm || !adresseFournisseur || !lignes || !Array.isArray(lignes)) {
//       return res.status(400).json({ message: 'Champs obligatoires manquants : numéro, type, clientNom, clientRccm, adresseFournisseur, ou lignes' });
//     }
  
//     // Validation du RCCM avec la nouvelle regex
//     const rccmRegex = /^(RC|RM)\/[A-Z]{2}\/[A-Z]{3}\/\d{4}\/[A-Z]\d{4,5}$/;
//     console.log(`Validation RCCM : reçu="${clientRccm}"`); // Log pour débogage
//     if (!rccmRegex.test(clientRccm)) {
//       return res.status(400).json({ 
//         message: `RCCM invalide : "${clientRccm}" (attendu ex. RC/TG/LOM/2023/A00987)`,
//         details: 'Format RCCM incorrect'
//       });
//     }
  
//     // Validation des lignes
//     if (lignes.length === 0 || lignes.some(ligne => !ligne.description || ligne.description.trim() === '' || ligne.quantite <= 0 || ligne.prixUnitaire <= 0)) {
//       return res.status(400).json({ message: 'Les lignes doivent avoir une description non vide, une quantité positive et un prix unitaire positif' });
//     }
  
//     // Vérification de la devise (par défaut XOF)
//     if (devise && devise !== 'XOF') {
//       return res.status(400).json({ message: 'Devise non prise en charge (seul XOF est autorisé)' });
//     }
  
//     next();
// };
  
// module.exports = {
//     invoice: validateInvoice,
// };

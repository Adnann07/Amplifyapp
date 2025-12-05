import 'package:flutter/material.dart';
import 'dart:math';

class MedicalFlashcardPage extends StatefulWidget {
  const MedicalFlashcardPage({super.key});

  @override
  State<MedicalFlashcardPage> createState() => _MedicalFlashcardPageState();
}

class _MedicalFlashcardPageState extends State<MedicalFlashcardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PageController _pageController;
  int currentIndex = 0;
  bool showAnswer = false;
  late List<Flashcard> flashcards;
  late List<Flashcard> anatomyFlashcards;
  late List<Flashcard> physiologyFlashcards;
  String selectedSubject = 'Anatomy'; // Default subject
  int _selectedSubjectIndex = 0; // 0 for Anatomy, 1 for Physiology

  @override
  void initState() {
    super.initState();
    anatomyFlashcards = _generateAnatomyFlashcards();
    physiologyFlashcards = _generatePhysiologyFlashcards();
    flashcards = anatomyFlashcards; // Start with Anatomy
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _pageController = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  List<Flashcard> _generateAnatomyFlashcards() {
    return [
      // A. General Anatomy Terminology [file:2]
      Flashcard(question: "What is anatomy?", answer: "The study of the structure of the human body and the relationships between its parts.", category: "General Anatomy", icon: Icons.local_hospital),
      Flashcard(question: "Name the three main branches of anatomy taught in 1st year MBBS.", answer: "Gross anatomy, histology, embryology.", category: "General Anatomy", icon: Icons.science),
      Flashcard(question: "What is gross anatomy?", answer: "Study of structures visible to the naked eye, usually by dissection.", category: "General Anatomy", icon: Icons.visibility),
      Flashcard(question: "What is microscopic anatomy?", answer: "Study of tissues and cells with a microscope (histology).", category: "General Anatomy", icon: Icons.zoom_in),
      Flashcard(question: "What is embryology?", answer: "Study of development of the organism from fertilization to birth.", category: "General Anatomy", icon: Icons.psychology),
      Flashcard(question: "Define anatomical position.", answer: "Standing erect, face forward, arms by sides, palms forward, feet together, toes forward.", category: "General Anatomy", icon: Icons.straighten),
      Flashcard(question: "Name three main anatomical planes.", answer: "Sagittal, coronal, transverse.", category: "General Anatomy", icon: Icons.crop_square),
      Flashcard(question: "What is the median plane?", answer: "Sagittal plane that passes through the midline, dividing the body into equal right and left halves.", category: "General Anatomy", icon: Icons.center_focus_strong),
      Flashcard(question: "What is a sagittal plane?", answer: "Vertical plane parallel to the median plane.", category: "General Anatomy", icon: Icons.aspect_ratio),
      Flashcard(question: "What is a coronal plane?", answer: "Vertical plane that divides the body into anterior and posterior parts.", category: "General Anatomy", icon: Icons.crop_portrait),
      Flashcard(question: "What is a transverse plane?", answer: "Horizontal plane that divides the body into superior and inferior parts.", category: "General Anatomy", icon: Icons.layers),
      Flashcard(question: "Define superior and inferior.", answer: "Superior: nearer the head; inferior: nearer the feet.", category: "General Anatomy", icon: Icons.trending_up),
      Flashcard(question: "Define anterior and posterior.", answer: "Anterior: nearer the front; posterior: nearer the back.", category: "General Anatomy", icon: Icons.arrow_forward),
      Flashcard(question: "Define medial and lateral.", answer: "Medial: nearer the median plane; lateral: farther from the median plane.", category: "General Anatomy", icon: Icons.compare_arrows),
      Flashcard(question: "Define proximal and distal.", answer: "Proximal: nearer the trunk or point of origin; distal: farther from it.", category: "General Anatomy", icon: Icons.timeline),
      Flashcard(question: "Define superficial and deep.", answer: "Superficial: near the surface; deep: farther from the surface.", category: "General Anatomy", icon: Icons.layers_clear),
      Flashcard(question: "What does ipsilateral mean?", answer: "On the same side of the body.", category: "General Anatomy", icon: Icons.check_circle),
      Flashcard(question: "What does contralateral mean?", answer: "On the opposite side of the body.", category: "General Anatomy", icon: Icons.cancel),
      Flashcard(question: "Define flexion.", answer: "Bending movement that decreases the angle between two body parts.", category: "General Anatomy", icon: Icons.trending_down),
      Flashcard(question: "Define extension.", answer: "Straightening movement that increases the angle between two body parts.", category: "General Anatomy", icon: Icons.trending_up),
      Flashcard(question: "Define abduction.", answer: "Movement away from the midline of the body.", category: "General Anatomy", icon: Icons.open_with),
      Flashcard(question: "Define adduction.", answer: "Movement toward the midline of the body.", category: "General Anatomy", icon: Icons.close_fullscreen),
      Flashcard(question: "Define medial rotation.", answer: "Rotation of a limb toward the median plane.", category: "General Anatomy", icon: Icons.rotate_left),
      Flashcard(question: "Define lateral rotation.", answer: "Rotation of a limb away from the median plane.", category: "General Anatomy", icon: Icons.rotate_right),
      Flashcard(question: "Define pronation.", answer: "Rotation of forearm so palm faces posteriorly in anatomical position.", category: "General Anatomy", icon: Icons.rotate_90_degrees_ccw),
      Flashcard(question: "Define supination.", answer: "Rotation of forearm so palm faces anteriorly.", category: "General Anatomy", icon: Icons.rotate_90_degrees_cw),
      Flashcard(question: "What is circumduction?", answer: "Circular movement combining flexion, extension, abduction, and adduction.", category: "General Anatomy", icon: Icons.all_inclusive),

      // B. Bones Classification and Structure [file:2]
      Flashcard(question: "Define bone.", answer: "Rigid, mineralized connective tissue forming the skeleton.", category: "Bones", icon: Icons.account_balance),
      Flashcard(question: "List four functions of bone.", answer: "Support, protection, movement levers, mineral storage, blood cell formation.", category: "Bones", icon: Icons.support_agent),
      Flashcard(question: "How are bones classified by shape?", answer: "Long, short, flat, irregular, sesamoid, pneumatic.", category: "Bones", icon: Icons.category),
      Flashcard(question: "Example of a long bone.", answer: "Femur (also humerus, radius, ulna, etc.).", category: "Bones", icon: Icons.arrow_upward),
      Flashcard(question: "Example of a short bone.", answer: "Carpal bones.", category: "Bones", icon: Icons.radio_button_unchecked),
      Flashcard(question: "Example of a flat bone.", answer: "Parietal bone, sternum, ribs, scapula.", category: "Bones", icon: Icons.crop_square),
      Flashcard(question: "Example of an irregular bone.", answer: "Vertebra.", category: "Bones", icon: Icons.view_in_ar),
      Flashcard(question: "Example of a sesamoid bone.", answer: "Patella.", category: "Bones", icon: Icons.lens),
      Flashcard(question: "What is a pneumatic bone?", answer: "Bone containing air-filled cavities, e.g., maxilla, frontal bone.", category: "Bones", icon: Icons.air),
      Flashcard(question: "Name the parts of a typical long bone.", answer: "Diaphysis, epiphyses, metaphyses, medullary cavity, periosteum, endosteum.", category: "Bones", icon: Icons.layers),
      Flashcard(question: "What is the diaphysis?", answer: "Shaft of a long bone.", category: "Bones", icon: Icons.line_weight),
      Flashcard(question: "What is the epiphysis?", answer: "Expanded ends of a long bone.", category: "Bones", icon: Icons.rounded_corner),
      Flashcard(question: "What is the metaphysis?", answer: "Junction between diaphysis and epiphysis (contains growth plate in growing bone).", category: "Bones", icon: Icons.join_inner),
      Flashcard(question: "What is the epiphyseal plate?", answer: "Cartilaginous growth plate where longitudinal bone growth occurs.", category: "Bones", icon: Icons.add_circle_outline),
      Flashcard(question: "What is periosteum?", answer: "Fibrous membrane covering outer surface of bone except articular areas.", category: "Bones", icon: Icons.texture),
      Flashcard(question: "Functions of periosteum.", answer: "Bone growth in thickness, repair, attachment of muscles/ligaments, carries blood vessels.", category: "Bones", icon: Icons.build),
      Flashcard(question: "What is endosteum?", answer: "Thin membrane lining the inner surfaces (medullary cavity, trabeculae).", category: "Bones", icon: Icons.line_style),
      Flashcard(question: "Two main types of bone tissue.", answer: "Compact (cortical) and spongy (cancellous).", category: "Bones", icon: Icons.texture),
      Flashcard(question: "Where is compact bone mainly found in a long bone?", answer: "Diaphysis (shaft) forming a strong outer shell.", category: "Bones", icon: Icons.square_foot),
      Flashcard(question: "Where is spongy bone mainly found?", answer: "Epiphyses, metaphyses, and inside flat bones.", category: "Bones", icon: Icons.grid_on),
      Flashcard(question: "What is the main inorganic component of bone?", answer: "Hydroxyapatite (calcium phosphate crystals).", category: "Bones", icon: Icons.science),
      Flashcard(question: "Name the main cells found in bone.", answer: "Osteoblasts, osteocytes, osteoclasts, osteoprogenitor cells.", category: "Bones", icon: Icons.people),
      Flashcard(question: "Function of osteoblasts.", answer: "Bone-forming cells (secrete bone matrix).", category: "Bones", icon: Icons.add_box),
      Flashcard(question: "Function of osteocytes.", answer: "Mature bone cells (maintain bone matrix).", category: "Bones", icon: Icons.settings),
      Flashcard(question: "Function of osteoclasts.", answer: "Bone-resorbing cells (break down bone).", category: "Bones", icon: Icons.remove_circle),

      // C. Joints Classification and Examples [file:2]
      Flashcard(question: "Define a joint.", answer: "Junction between two or more bones or cartilages.", category: "Joints", icon: Icons.join_inner),
      Flashcard(question: "Three structural types of joints.", answer: "Fibrous, cartilaginous, synovial.", category: "Joints", icon: Icons.layers),
      Flashcard(question: "What is a fibrous joint?", answer: "Bones joined by fibrous tissue with little or no movement, e.g., sutures of skull.", category: "Joints", icon: Icons.link),
      Flashcard(question: "What is a cartilaginous joint?", answer: "Bones joined by cartilage (slight movement), e.g., intervertebral discs, pubic symphysis.", category: "Joints", icon: Icons.circle_notifications),
      Flashcard(question: "What is a synovial joint?", answer: "Freely movable joint with synovial cavity, synovial fluid, articular cartilage, and capsule.", category: "Joints", icon: Icons.ballot),
      Flashcard(question: "Name the basic components of a synovial joint.", answer: "Articular cartilage, joint cavity, synovial membrane, fibrous capsule, ligaments, sometimes menisci/bursae.", category: "Joints", icon: Icons.list),
      Flashcard(question: "Example of a fibrous joint.", answer: "Sutures of skull, distal tibiofibular joint.", category: "Joints", icon: Icons.border_all),
      Flashcard(question: "Example of a primary cartilaginous joint.", answer: "Epiphyseal plate (synchondrosis).", category: "Joints", icon: Icons.circle_outlined),
      Flashcard(question: "Example of a secondary cartilaginous joint.", answer: "Pubic symphysis, intervertebral joints.", category: "Joints", icon: Icons.circle),
      Flashcard(question: "Classification of synovial joints by shape.", answer: "Plane, hinge, pivot, condylar (ellipsoid), saddle, ball-and-socket.", category: "Joints", icon: Icons.category),
      Flashcard(question: "Example of a hinge joint.", answer: "Elbow joint, interphalangeal joints.", category: "Joints", icon: Icons.rotate_left),
      Flashcard(question: "Example of a ball-and-socket joint.", answer: "Shoulder joint, hip joint.", category: "Joints", icon: Icons.sports_soccer),
      Flashcard(question: "Example of a pivot joint.", answer: "Atlantoaxial joint, proximal radioulnar joint.", category: "Joints", icon: Icons.rotate_90_degrees_cw),
      Flashcard(question: "Example of a saddle joint.", answer: "First carpometacarpal joint (thumb).", category: "Joints", icon: Icons.apps),
      Flashcard(question: "Example of a condylar joint.", answer: "Wrist joint, metacarpophalangeal joints.", category: "Joints", icon: Icons.keyboard_arrow_down),
      Flashcard(question: "Example of a plane joint.", answer: "Intercarpal joints, acromioclavicular joint.", category: "Joints", icon: Icons.crop_free),

      // D. Muscles Types, Structure, Actions [file:2]
      Flashcard(question: "Three types of muscle tissue.", answer: "Skeletal, cardiac, smooth.", category: "Muscles", icon: Icons.fitness_center),
      Flashcard(question: "Which muscle type is striated and voluntary?", answer: "Skeletal muscle.", category: "Muscles", icon: Icons.directions_run),
      Flashcard(question: "Which muscle type is striated and involuntary?", answer: "Cardiac muscle.", category: "Muscles", icon: Icons.favorite),
      Flashcard(question: "Which muscle type is non-striated and involuntary?", answer: "Smooth muscle.", category: "Muscles", icon: Icons.tonality),
      Flashcard(question: "What is the origin of a muscle?", answer: "Fixed or less mobile attachment.", category: "Muscles", icon: Icons.flag),
      Flashcard(question: "What is the insertion of a muscle?", answer: "More mobile attachment.", category: "Muscles", icon: Icons.location_pin),
      Flashcard(question: "Define agonist (prime mover).", answer: "Muscle mainly responsible for a specific movement.", category: "Muscles", icon: Icons.speed),
      Flashcard(question: "Define antagonist muscle.", answer: "Muscle that opposes the action of the agonist.", category: "Muscles", icon: Icons.block),
      Flashcard(question: "Define synergist.", answer: "Muscle that assists the prime mover.", category: "Muscles", icon: Icons.group),
      Flashcard(question: "Define fixator.", answer: "Muscle that stabilizes the origin of the prime mover.", category: "Muscles", icon: Icons.settings),
      Flashcard(question: "What is a tendon?", answer: "Fibrous cord connecting muscle to bone.", category: "Muscles", icon: Icons.line_weight),
      Flashcard(question: "What is an aponeurosis?", answer: "Flattened sheet-like tendon.", category: "Muscles", icon: Icons.crop),
      Flashcard(question: "What is a fascial compartment?", answer: "Group of muscles with similar function and nerve supply enclosed by deep fascia.", category: "Muscles", icon: Icons.dashboard),
      Flashcard(question: "Example of a muscle with multipennate arrangement.", answer: "Deltoid.", category: "Muscles", icon: Icons.layers),
      Flashcard(question: "Example of a fusiform muscle.", answer: "Biceps brachii.", category: "Muscles", icon: Icons.circle),
      Flashcard(question: "Example of a circular sphincter muscle.", answer: "Orbicularis oculi or orbicularis oris.", category: "Muscles", icon: Icons.remove_red_eye),

      // E. Skin and Fascia [file:2]
      Flashcard(question: "Name the two main layers of skin.", answer: "Epidermis and dermis.", category: "Skin", icon: Icons.texture),
      Flashcard(question: "What is the epidermis?", answer: "Superficial, avascular, stratified squamous keratinized epithelium.", category: "Skin", icon: Icons.layers),
      Flashcard(question: "What is the dermis?", answer: "Deep connective tissue layer containing blood vessels, nerves, and appendages.", category: "Skin", icon: Icons.bloodtype),
      Flashcard(question: "Name the two layers of dermis.", answer: "Papillary layer and reticular layer.", category: "Skin", icon: Icons.layers_clear),
      Flashcard(question: "What is superficial fascia?", answer: "Subcutaneous tissue containing fat, superficial vessels, and nerves, beneath skin.", category: "Skin", icon: Icons.layers_outlined),
      Flashcard(question: "What is deep fascia?", answer: "Dense fibrous connective tissue investing muscles and forming compartments.", category: "Skin", icon: Icons.square_foot),
      Flashcard(question: "Clinical importance of superficial veins in limbs.", answer: "Used for venepuncture, IV access (sites of varicose veins).", category: "Skin", icon: Icons.medical_services),
      Flashcard(question: "What is a bursa?", answer: "Fluid-filled sac that reduces friction between bone and tendon/skin.", category: "Skin", icon: Icons.water_drop),
      Flashcard(question: "What is a tendon sheath?", answer: "Tubular bursa surrounding a tendon where it passes through a tunnel.", category: "Skin", icon: Icons.line_style),

      // F. Histology General Principles [file:2]
      Flashcard(question: "What is histology?", answer: "Study of microscopic structure of tissues and organs.", category: "Histology", icon: Icons.zoom_in),
      Flashcard(question: "Name the four basic tissue types.", answer: "Epithelium, connective tissue, muscle, nervous tissue.", category: "Histology", icon: Icons.layers),
      Flashcard(question: "What is epithelium?", answer: "Tissue that covers surfaces, lines cavities, and forms glands.", category: "Histology", icon: Icons.crop_square),
      Flashcard(question: "Main functions of epithelium.", answer: "Protection, absorption, secretion, excretion, sensation.", category: "Histology", icon: Icons.security),
      Flashcard(question: "How is epithelium classified?", answer: "By number of layers (simple, stratified, pseudostratified) and cell shape (squamous, cuboidal, columnar).", category: "Histology", icon: Icons.category),
      Flashcard(question: "Define simple epithelium.", answer: "Single layer of cells resting on a basement membrane.", category: "Histology", icon: Icons.layers_outlined),
      Flashcard(question: "Define stratified epithelium.", answer: "Two or more layers of cells (only basal layer rests on basement membrane).", category: "Histology", icon: Icons.layers),
      Flashcard(question: "Example and site of simple squamous epithelium.", answer: "Endothelium (lining blood vessels), mesothelium of serous membranes.", category: "Histology", icon: Icons.texture),
      Flashcard(question: "Example and site of simple cuboidal epithelium.", answer: "Tubules of kidney, ducts of small glands.", category: "Histology", icon: Icons.radio_button_unchecked),
      Flashcard(question: "Example and site of simple columnar epithelium.", answer: "Lining of stomach, small intestine.", category: "Histology", icon: Icons.height),
      Flashcard(question: "Example and site of pseudostratified ciliated columnar epithelium.", answer: "Respiratory tract (trachea, bronchi).", category: "Histology", icon: Icons.air),
      Flashcard(question: "Example and site of stratified squamous non-keratinized epithelium.", answer: "Oral cavity, esophagus, vagina.", category: "Histology", icon: Icons.layers_clear),
      Flashcard(question: "Example and site of stratified squamous keratinized epithelium.", answer: "Epidermis of skin.", category: "Histology", icon: Icons.texture),
      Flashcard(question: "What is transitional epithelium?", answer: "Stratified epithelium specialized for stretch, lining urinary bladder.", category: "Histology", icon: Icons.change_circle),
      Flashcard(question: "What is the basement membrane?", answer: "Specialized extracellular layer between epithelium and underlying connective tissue.", category: "Histology", icon: Icons.line_style),
      Flashcard(question: "Name two components of basement membrane.", answer: "Basal lamina and reticular lamina.", category: "Histology", icon: Icons.layers),
      Flashcard(question: "What are microvilli?", answer: "Finger-like projections of cell membrane that increase surface area for absorption.", category: "Histology", icon: Icons.texture),
      Flashcard(question: "Where are microvilli abundant?", answer: "Small intestine, proximal convoluted tubule of kidney.", category: "Histology", icon: Icons.height),

      // G. Histology Connective Tissue [file:2]
      Flashcard(question: "What is connective tissue?", answer: "Tissue that supports, binds, and connects other tissues.", category: "Histology", icon: Icons.support_agent),
      Flashcard(question: "Main components of connective tissue.", answer: "Cells, fibers, ground substance.", category: "Histology", icon: Icons.list),
      Flashcard(question: "Name three types of connective tissue fibers.", answer: "Collagen, elastic, reticular fibers.", category: "Histology", icon: Icons.layers),
      Flashcard(question: "Most abundant fiber in connective tissue.", answer: "Collagen fiber.", category: "Histology", icon: Icons.straighten),
      Flashcard(question: "Function of elastic fibers.", answer: "Provide elasticity and resilience.", category: "Histology", icon: Icons.extension),
      Flashcard(question: "Main cell type in ordinary connective tissue.", answer: "Fibroblast.", category: "Histology", icon: Icons.person),
      Flashcard(question: "Name a phagocytic cell of connective tissue.", answer: "Macrophage.", category: "Histology", icon: Icons.cleaning_services),
      Flashcard(question: "Function of plasma cells.", answer: "Produce antibodies.", category: "Histology", icon: Icons.security),
      Flashcard(question: "Function of mast cells.", answer: "Release histamine and other mediators in allergic reactions.", category: "Histology", icon: Icons.coronavirus),

      // H. Histology Cartilage Bone microscopic [file:2]
      Flashcard(question: "Main cells of cartilage.", answer: "Chondrocytes.", category: "Histology", icon: Icons.circle_notifications),
      Flashcard(question: "Three types of cartilage.", answer: "Hyaline, elastic, fibrocartilage.", category: "Histology", icon: Icons.layers),
      Flashcard(question: "Example of hyaline cartilage.", answer: "Articular cartilage, tracheal rings, costal cartilage.", category: "Histology", icon: Icons.circle),
      Flashcard(question: "Example of elastic cartilage.", answer: "External ear (pinna), epiglottis.", category: "Histology", icon: Icons.hearing),
      Flashcard(question: "Example of fibrocartilage.", answer: "Intervertebral discs, pubic symphysis.", category: "Histology", icon: Icons.layers_clear),
      Flashcard(question: "What is perichondrium?", answer: "Dense connective tissue surrounding cartilage except articular cartilage.", category: "Histology", icon: Icons.texture),
      Flashcard(question: "What is an osteon (Haversian system)?", answer: "Structural unit of compact bone consisting of concentric lamellae around a central canal.", category: "Histology", icon: Icons.circle),
      Flashcard(question: "What are canaliculi in bone?", answer: "Small channels connecting lacunae for exchange between osteocytes.", category: "Histology", icon: Icons.zoom_out_map),

      // I. Histology Muscle [file:2]
      Flashcard(question: "Histological feature of skeletal muscle.", answer: "Long, cylindrical, multinucleated cells with striations (nuclei at periphery).", category: "Histology", icon: Icons.fitness_center),
      Flashcard(question: "Histological feature of cardiac muscle.", answer: "Branched, striated fibers with central nuclei and intercalated discs.", category: "Histology", icon: Icons.favorite),
      Flashcard(question: "Histological feature of smooth muscle.", answer: "Spindle-shaped non-striated cells with single central nucleus.", category: "Histology", icon: Icons.tonality),

      // J. Histology Nervous Tissue [file:2]
      Flashcard(question: "Main cell types in nervous tissue.", answer: "Neurons and neuroglia (glial cells).", category: "Histology", icon: Icons.people),
      Flashcard(question: "What is a neuron?", answer: "Structural and functional unit of nervous system, specialized for conduction.", category: "Histology", icon: Icons.electrical_services),
      Flashcard(question: "Parts of a typical neuron.", answer: "Cell body, dendrites, axon.", category: "Histology", icon: Icons.account_tree),
      Flashcard(question: "What is myelin sheath?", answer: "Fatty insulating covering around axons formed by Schwann cells (PNS) or oligodendrocytes (CNS).", category: "Histology", icon: Icons.texture),
      Flashcard(question: "Function of myelin.", answer: "Increases speed of nerve impulse conduction.", category: "Histology", icon: Icons.speed),

      // K-M. General Embryology [file:2]
      Flashcard(question: "What is embryology?", answer: "Study of development of an individual from fertilization to birth.", category: "Embryology", icon: Icons.psychology),
      Flashcard(question: "What is gametogenesis?", answer: "Process of formation of male and female gametes (spermatogenesis, oogenesis).", category: "Embryology", icon: Icons.whatshot),
      Flashcard(question: "What is fertilization?", answer: "Fusion of sperm and ovum to form a zygote.", category: "Embryology", icon: Icons.merge),
      Flashcard(question: "Normal site of fertilization in humans.", answer: "Ampulla of uterine tube.", category: "Embryology", icon: Icons.location_pin),
      Flashcard(question: "What is a zygote?", answer: "Single-celled diploid product of fertilization.", category: "Embryology", icon: Icons.circle),
      Flashcard(question: "What is cleavage?", answer: "Series of mitotic divisions of zygote forming smaller cells called blastomeres.", category: "Embryology", icon: Icons.autorenew),
      Flashcard(question: "What is a morula?", answer: "Solid ball of 16-32 cells formed by cleavage.", category: "Embryology", icon: Icons.circle),
      Flashcard(question: "What is a blastocyst?", answer: "Early embryo with fluid-filled cavity, inner cell mass, and trophoblast.", category: "Embryology", icon: Icons.water_drop),
      Flashcard(question: "What is implantation?", answer: "Process by which blastocyst embeds into endometrium of uterus.", category: "Embryology", icon: Icons.home),
      Flashcard(question: "Normal site of implantation.", answer: "Upper posterior wall of uterus.", category: "Embryology", icon: Icons.location_on),
      Flashcard(question: "What is gastrulation?", answer: "Process forming three germ layers (ectoderm, mesoderm, endoderm).", category: "Embryology", icon: Icons.layers),
      Flashcard(question: "Name the three primary germ layers.", answer: "Ectoderm, mesoderm, endoderm.", category: "Embryology", icon: Icons.layers),
      Flashcard(question: "Derivatives of ectoderm (one example each category).", answer: "Epidermis of skin, nervous system, enamel of teeth.", category: "Embryology", icon: Icons.layers),
      Flashcard(question: "Derivatives of mesoderm (two examples).", answer: "Muscles, bones, blood, cardiovascular system, urogenital system.", category: "Embryology", icon: Icons.fitness_center),
      Flashcard(question: "Derivatives of endoderm (two examples).", answer: "Epithelium of GI tract, respiratory tract, liver, pancreas.", category: "Embryology", icon: Icons.restaurant),
      Flashcard(question: "What are extraembryonic membranes?", answer: "Membranes formed from embryo but lying outside it (yolk sac, amnion, chorion, allantois).", category: "Embryology", icon: Icons.layers_outlined),
      Flashcard(question: "What is the placenta?", answer: "Organ formed by fetal chorion and maternal decidua for exchange of substances.", category: "Embryology", icon: Icons.whatshot),
      Flashcard(question: "When does fetal period start?", answer: "From 9th week of development until birth.", category: "Embryology", icon: Icons.timeline),
    ];
  }

  List<Flashcard> _generatePhysiologyFlashcards() {
    return [
      // A. General Physiology
      Flashcard(question: "What is physiology?", answer: "Study of functions of living organisms and their parts, how they work to maintain life.", category: "General Physiology", icon: Icons.functions),
      Flashcard(question: "Define homeostasis.", answer: "Maintenance of constant internal environment despite external changes.", category: "General Physiology", icon: Icons.balance),
      Flashcard(question: "What are the two main types of homeostatic control systems?", answer: "Negative feedback, positive feedback.", category: "General Physiology", icon: Icons.compare_arrows),
      Flashcard(question: "What is negative feedback? Give example.", answer: "Change produces response opposing the change. Ex: blood glucose regulation by insulin.", category: "General Physiology", icon: Icons.trending_down),
      Flashcard(question: "What is positive feedback? Give example.", answer: "Change produces response reinforcing the change. Ex: blood clotting, labor (oxytocin).", category: "General Physiology", icon: Icons.trending_up),
      Flashcard(question: "Name components of a reflex arc.", answer: "Receptor → afferent neuron → integration center → efferent neuron → effector.", category: "General Physiology", icon: Icons.account_tree),
      Flashcard(question: "What is a local reflex?", answer: "Response occurs without CNS involvement (ex: local vascular response).", category: "General Physiology", icon: Icons.location_on),

      // B. Cell Physiology
      Flashcard(question: "What is resting membrane potential (RMP)?", answer: "Electrical potential difference across cell membrane at rest (~ -70 mV inside negative).", category: "Cell Physiology", icon: Icons.electrical_services),
      Flashcard(question: "Main ions responsible for RMP.", answer: "K⁺ (high permeability), Na⁺ (low permeability), large negative anions inside.", category: "Cell Physiology", icon: Icons.battery_charging_full),
      Flashcard(question: "Goldman equation determines what?", answer: "Membrane potential based on ion permeabilities and concentrations.", category: "Cell Physiology", icon: Icons.calculate),
      Flashcard(question: "What is action potential?", answer: "Rapid change in membrane potential: depolarization → repolarization → hyperpolarization.", category: "Cell Physiology", icon: Icons.bolt),
      Flashcard(question: "Voltage-gated Na⁺ channels role in action potential.", answer: "Open during depolarization phase (threshold -55 mV).", category: "Cell Physiology", icon: Icons.arrow_upward),
      Flashcard(question: "Voltage-gated K⁺ channels role.", answer: "Open during repolarization phase.", category: "Cell Physiology", icon: Icons.arrow_downward),
      Flashcard(question: "What is absolute refractory period?", answer: "Period when no stimulus can trigger another action potential (Na⁺ channels inactivated).", category: "Cell Physiology", icon: Icons.block),
      Flashcard(question: "Conduction velocity fastest in what type of nerve fiber?", answer: "Myelinated fibers (saltatory conduction).", category: "Cell Physiology", icon: Icons.speed),
      Flashcard(question: "Types of transport across cell membrane.", answer: "Passive (diffusion, facilitated), active (primary, secondary).", category: "Cell Physiology", icon: Icons.compare_arrows),
      Flashcard(question: "Na⁺/K⁺ ATPase function.", answer: "Pumps 3 Na⁺ out, 2 K⁺ in (uses ATP); maintains ion gradients.", category: "Cell Physiology", icon: Icons.repeat),

      // C. Blood Physiology
      Flashcard(question: "Normal total blood volume in adult male.", answer: "~5 liters (70 ml/kg body weight).", category: "Blood Physiology", icon: Icons.water_drop),
      Flashcard(question: "Hematocrit normal range (male).", answer: "40-50% (RBC volume/total blood volume).", category: "Blood Physiology", icon: Icons.pie_chart),
      Flashcard(question: "Plasma volume normal value.", answer: "~3 liters (male).", category: "Blood Physiology", icon: Icons.science),
      Flashcard(question: "Plasma proteins main types (3).", answer: "Albumin (60%), globulins (35%), fibrinogen (4%).", category: "Blood Physiology", icon: Icons.layers),
      Flashcard(question: "Albumin main functions (2).", answer: "Maintains colloid osmotic pressure (25 mmHg), carrier protein.", category: "Blood Physiology", icon: Icons.opacity),
      Flashcard(question: "Erythropoiesis site in adults.", answer: "Red bone marrow (flat bones: vertebrae, pelvis, ribs, skull, sternum).", category: "Blood Physiology", icon: Icons.factory),
      Flashcard(question: "Hormone stimulating erythropoiesis.", answer: "Erythropoietin (from peritubular kidney cells).", category: "Blood Physiology", icon: Icons.medical_services),
      Flashcard(question: "Hemoglobin structure.", answer: "4 globin chains + 4 heme groups (each with Fe²⁺).", category: "Blood Physiology", icon: Icons.architecture),
      Flashcard(question: "HbA adult normal percentage.", answer: "97% (2α + 2β chains).", category: "Blood Physiology", icon: Icons.percent),
      Flashcard(question: "2,3-BPG effect on Hb-O₂ affinity.", answer: "Decreases affinity (right shift of dissociation curve).", category: "Blood Physiology", icon: Icons.trending_flat),
      Flashcard(question: "Oxygen dissociation curve shape.", answer: "Sigmoid (cooperative binding).", category: "Blood Physiology", icon: Icons.show_chart),
      Flashcard(question: "Factors causing right shift (Bohr effect).", answer: "↑CO₂, ↓pH, ↑2,3-BPG, ↑temperature.", category: "Blood Physiology", icon: Icons.trending_up),
      Flashcard(question: "Fetal Hb (HbF) advantage.", answer: "Higher O₂ affinity than HbA (γ chains bind 2,3-BPG less).", category: "Blood Physiology", icon: Icons.child_care),
      Flashcard(question: "Iron daily requirement (male).", answer: "1 mg (women 1.5-2 mg due to menstruation).", category: "Blood Physiology", icon: Icons.construction),
      Flashcard(question: "RBC lifespan.", answer: "120 days.", category: "Blood Physiology", icon: Icons.timelapse),
      Flashcard(question: "ESR normal value (male).", answer: "0-10 mm/hr.", category: "Blood Physiology", icon: Icons.timeline),
      Flashcard(question: "Anemia definition.", answer: "Hb <13 g/dl (male), <12 g/dl (female).", category: "Blood Physiology", icon: Icons.warning),
      Flashcard(question: "Microcytic hypochromic anemia common cause.", answer: "Iron deficiency.", category: "Blood Physiology", icon: Icons.do_not_disturb),
      Flashcard(question: "Megaloblastic anemia cause.", answer: "B₁₂ or folate deficiency.", category: "Blood Physiology", icon: Icons.do_not_disturb_on),
      Flashcard(question: "Blood groups basis.", answer: "ABO antigens on RBC surface + antibodies in plasma.", category: "Blood Physiology", icon: Icons.type_specimen),
      Flashcard(question: "Universal donor blood group.", answer: "O negative.", category: "Blood Physiology", icon: Icons.favorite),
      Flashcard(question: "Universal recipient.", answer: "AB positive.", category: "Blood Physiology", icon: Icons.favorite_border),
      Flashcard(question: "Rh incompatibility occurs when?", answer: "Rh- mother + Rh+ fetus (first pregnancy usually safe).", category: "Blood Physiology", icon: Icons.warning_amber),

      // D. Blood Coagulation
      Flashcard(question: "Coagulation cascade two pathways.", answer: "Intrinsic, extrinsic (both converge to common pathway).", category: "Coagulation", icon: Icons.account_tree),
      Flashcard(question: "Extrinsic pathway triggered by.", answer: "Tissue factor (factor III).", category: "Coagulation", icon: Icons.flash_on),
      Flashcard(question: "PT tests what pathway?", answer: "Extrinsic + common.", category: "Coagulation", icon: Icons.timer),
      Flashcard(question: "APTT tests what?", answer: "Intrinsic + common.", category: "Coagulation", icon: Icons.timer_10),
      Flashcard(question: "Vitamin K role.", answer: "Synthesis of factors II, VII, IX, X, protein C/S.", category: "Coagulation", icon: Icons.eco),
      Flashcard(question: "Hemophilia A deficiency.", answer: "Factor VIII.", category: "Coagulation", icon: Icons.healing),
      Flashcard(question: "Vitamin K antagonist.", answer: "Warfarin.", category: "Coagulation", icon: Icons.block),

      // E. Leukocytes & Immunity
      Flashcard(question: "Neutrophil percentage in blood.", answer: "60-70%.", category: "Immunity", icon: Icons.pie_chart),
      Flashcard(question: "Lymphocyte functions.", answer: "T-cells (cellular immunity), B-cells (humoral).", category: "Immunity", icon: Icons.security),
      Flashcard(question: "Eosinophil increased in.", answer: "Parasitic infections, allergies.", category: "Immunity", icon: Icons.bug_report),
      Flashcard(question: "Monocyte becomes what in tissues?", answer: "Macrophage.", category: "Immunity", icon: Icons.transform),
      Flashcard(question: "Basophil main content.", answer: "Histamine, heparin.", category: "Immunity", icon: Icons.water_damage),

      // F. Nerve Physiology
      Flashcard(question: "Nerve fiber classification (Erlanger-Gasser).", answer: "A (α,β,γ,δ), B, C fibers.", category: "Nerve Physiology", icon: Icons.category),
      Flashcard(question: "Aα fibers function.", answer: "Motor to skeletal muscle, proprioception (fastest, 80-120 m/s).", category: "Nerve Physiology", icon: Icons.directions_run),
      Flashcard(question: "Pain fibers types.", answer: "Aδ (fast, sharp), C (slow, dull/aching).", category: "Nerve Physiology", icon: Icons.whatshot),
      Flashcard(question: "Synapse definition.", answer: "Junction between two neurons (or neuron-effector).", category: "Nerve Physiology", icon: Icons.join_inner),
      Flashcard(question: "Excitatory neurotransmitter.", answer: "Glutamate (most common).", category: "Nerve Physiology", icon: Icons.add_circle),
      Flashcard(question: "Inhibitory neurotransmitter in CNS.", answer: "GABA, glycine.", category: "Nerve Physiology", icon: Icons.remove_circle),
      Flashcard(question: "Neuromuscular junction neurotransmitter.", answer: "Acetylcholine.", category: "Nerve Physiology", icon: Icons.electric_bolt),
      Flashcard(question: "AChE function.", answer: "Hydrolyzes ACh to terminate action.", category: "Nerve Physiology", icon: Icons.cleaning_services),
      Flashcard(question: "Myasthenia gravis pathology.", answer: "Autoantibodies against ACh receptors.", category: "Nerve Physiology", icon: Icons.health_and_safety),

      // G. Muscle Physiology
      Flashcard(question: "Muscle twitch phases.", answer: "Latent period → contraction → relaxation.", category: "Muscle Physiology", icon: Icons.timeline),
      Flashcard(question: "Length-tension relationship.", answer: "Maximum tension at optimal sarcomere length (~2.2 μm).", category: "Muscle Physiology", icon: Icons.straighten),
      Flashcard(question: "Sliding filament theory basis.", answer: "Actin-myosin cross-bridge cycling shortens sarcomere.", category: "Muscle Physiology", icon: Icons.compare_arrows),
      Flashcard(question: "Power stroke triggered by.", answer: "Release of ADP + Pi from myosin head.", category: "Muscle Physiology", icon: Icons.flash_on),
      Flashcard(question: "Muscle fatigue main cause.", answer: "Lactic acid accumulation, ATP depletion.", category: "Muscle Physiology", icon: Icons.sentiment_dissatisfied),
      Flashcard(question: "Smooth muscle excitation-contraction coupling.", answer: "Ca²⁺ binds calmodulin → activates myosin light chain kinase.", category: "Muscle Physiology", icon: Icons.link),
      Flashcard(question: "Tetanus (muscle).", answer: "Sustained maximal contraction from rapid stimuli fusing twitches.", category: "Muscle Physiology", icon: Icons.pause),
      Flashcard(question: "Treppe phenomenon.", answer: "Progressive ↑force of successive twitches (warm-up).", category: "Muscle Physiology", icon: Icons.trending_up),
      Flashcard(question: "Cardiac muscle unique feature.", answer: "Intercalated discs, functional syncytium.", category: "Muscle Physiology", icon: Icons.favorite),

      // H. More Blood Details
      Flashcard(question: "RBC production regulated by.", answer: "Tissue hypoxia → EPO release.", category: "Blood Details", icon: Icons.auto_graph),
      Flashcard(question: "Hb synthesis site.", answer: "Mitochondria (heme), cytoplasm (globin).", category: "Blood Details", icon: Icons.science),
      Flashcard(question: "Bilirubin from.", answer: "Heme breakdown (unconjugated → liver → conjugated).", category: "Blood Details", icon: Icons.change_circle),
      Flashcard(question: "Jaundice types (3).", answer: "Hemolytic, hepatic, obstructive.", category: "Blood Details", icon: Icons.warning),
      Flashcard(question: "PCV full form.", answer: "Packed cell volume (hematocrit).", category: "Blood Details", icon: Icons.abc),

      // I. Respiratory Physiology - Lung Volumes
      Flashcard(question: "Define tidal volume (TV).", answer: "Volume of air inspired or expired in quiet breathing (~500 ml).", category: "Respiratory", icon: Icons.air),
      Flashcard(question: "Define inspiratory reserve volume (IRV).", answer: "Extra volume that can be inspired after normal inspiration (~3000 ml).", category: "Respiratory", icon: Icons.add),
      Flashcard(question: "Define expiratory reserve volume (ERV).", answer: "Extra volume that can be expired after normal expiration (~1100 ml).", category: "Respiratory", icon: Icons.remove),
      Flashcard(question: "Define residual volume (RV).", answer: "Volume remaining in lungs after maximal expiration (~1200 ml).", category: "Respiratory", icon: Icons.settings_backup_restore),
      Flashcard(question: "Define vital capacity (VC).", answer: "TV + IRV + ERV (~4600 ml).", category: "Respiratory", icon: Icons.stacked_line_chart),
      Flashcard(question: "Define total lung capacity (TLC).", answer: "VC + RV (~5800 ml).", category: "Respiratory", icon: Icons.multiline_chart),
      Flashcard(question: "Define functional residual capacity (FRC).", answer: "ERV + RV (~2300 ml).", category: "Respiratory", icon: Icons.filter_frames),
      Flashcard(question: "Why can't RV be measured by simple spirometry?", answer: "It cannot be expired from lungs.", category: "Respiratory", icon: Icons.do_not_disturb),

      // J. Respiratory Mechanics
      Flashcard(question: "Main muscle of inspiration.", answer: "Diaphragm.", category: "Respiratory", icon: Icons.fitness_center),
      Flashcard(question: "Accessory muscles of inspiration.", answer: "External intercostals, sternocleidomastoid, scalenes.", category: "Respiratory", icon: Icons.group_add),
      Flashcard(question: "Muscles of forced expiration.", answer: "Internal intercostals, abdominal muscles.", category: "Respiratory", icon: Icons.group_work),
      Flashcard(question: "Intrapleural pressure at rest (approx).", answer: "About −5 cm H₂O.", category: "Respiratory", icon: Icons.speed),
      Flashcard(question: "What is lung compliance?", answer: "Change in volume per unit change in transpulmonary pressure.", category: "Respiratory", icon: Icons.trending_up),
      Flashcard(question: "Surfactant is produced by which cells?", answer: "Type II pneumocytes.", category: "Respiratory", icon: Icons.science),
      Flashcard(question: "Main component of surfactant.", answer: "Dipalmitoyl phosphatidylcholine (DPPC).", category: "Respiratory", icon: Icons.eco),
      Flashcard(question: "Surfactant function.", answer: "Reduces surface tension, prevents alveolar collapse.", category: "Respiratory", icon: Icons.security),
      Flashcard(question: "Law describing pressure–radius relation in alveoli.", answer: "Law of Laplace (P = 2T/r).", category: "Respiratory", icon: Icons.gavel),

      // K. Gas Exchange & Transport
      Flashcard(question: "What is partial pressure?", answer: "Pressure exerted by an individual gas in a mixture.", category: "Respiratory", icon: Icons.compress),
      Flashcard(question: "Normal arterial PO₂ (PaO₂).", answer: "~95–100 mmHg.", category: "Respiratory", icon: Icons.thermostat),
      Flashcard(question: "Normal arterial PCO₂ (PaCO₂).", answer: "~40 mmHg.", category: "Respiratory", icon: Icons.thermostat_auto),
      Flashcard(question: "Fick's law of diffusion states rate is proportional to what?", answer: "Surface area × diffusion coefficient × pressure gradient / thickness.", category: "Respiratory", icon: Icons.science),
      Flashcard(question: "Most CO₂ is transported in blood in what form?", answer: "Bicarbonate (HCO₃⁻).", category: "Respiratory", icon: Icons.water),
      Flashcard(question: "Chloride shift refers to what?", answer: "Entry of Cl⁻ into RBCs as HCO₃⁻ leaves.", category: "Respiratory", icon: Icons.swap_horiz),
      Flashcard(question: "Bohr effect is?", answer: "Effect of CO₂/H⁺ on O₂–Hb dissociation (right shift).", category: "Respiratory", icon: Icons.trending_up),
      Flashcard(question: "Haldane effect is?", answer: "Deoxygenated Hb carries more CO₂.", category: "Respiratory", icon: Icons.trending_down),

      // L. Control of Respiration
      Flashcard(question: "Main respiratory center location.", answer: "Medulla oblongata.", category: "Respiratory", icon: Icons.location_on),
      Flashcard(question: "Central chemoreceptors respond mainly to what?", answer: "Changes in CO₂ (via H⁺) in CSF.", category: "Respiratory", icon: Icons.monitor_heart),
      Flashcard(question: "Peripheral chemoreceptors location.", answer: "Carotid and aortic bodies.", category: "Respiratory", icon: Icons.location_searching),
      Flashcard(question: "Peripheral chemoreceptors respond mainly to what drop in PaO₂?", answer: "PaO₂ < 60 mmHg.", category: "Respiratory", icon: Icons.warning),
      Flashcard(question: "Most powerful physiological stimulus for breathing.", answer: "Increased PaCO₂.", category: "Respiratory", icon: Icons.priority_high),
      Flashcard(question: "Hering–Breuer inflation reflex mediated by what?", answer: "Lung stretch receptors via vagus.", category: "Respiratory", icon: Icons.settings_input_antenna),

      // M. GI Physiology - Overview
      Flashcard(question: "Main functions of GI tract.", answer: "Ingestion, digestion, absorption, motility, secretion, excretion.", category: "GI Physiology", icon: Icons.restaurant),
      Flashcard(question: "Enteric nervous system plexuses.", answer: "Myenteric (Auerbach's) and submucosal (Meissner's).", category: "GI Physiology", icon: Icons.account_tree),
      Flashcard(question: "Myenteric plexus mainly controls what?", answer: "GI motility.", category: "GI Physiology", icon: Icons.directions_run),
      Flashcard(question: "Submucosal plexus mainly controls what?", answer: "Secretion and blood flow.", category: "GI Physiology", icon: Icons.opacity),
      Flashcard(question: "What is peristalsis?", answer: "Propulsive movement: contraction above bolus, relaxation below.", category: "GI Physiology", icon: Icons.swap_vert),
      Flashcard(question: "What is segmentation?", answer: "Mixing movements in small intestine.", category: "GI Physiology", icon: Icons.blender),
      Flashcard(question: "Gastrocolic reflex is?", answer: "Increased colonic motility after meals.", category: "GI Physiology", icon: Icons.autorenew),

      // N. Saliva & Gastric Secretion
      Flashcard(question: "Main components of saliva.", answer: "Water, mucus, amylase, bicarbonate, IgA.", category: "GI Physiology", icon: Icons.water_drop),
      Flashcard(question: "Saliva is hypotonic/isotonic/hypertonic?", answer: "Hypotonic (at low flow).", category: "GI Physiology", icon: Icons.thermostat),
      Flashcard(question: "Main phases of gastric secretion.", answer: "Cephalic, gastric, intestinal.", category: "GI Physiology", icon: Icons.timeline),
      Flashcard(question: "Cephalic phase of gastric secretion stimulated by?", answer: "Sight, smell, thought, taste of food (vagal).", category: "GI Physiology", icon: Icons.psychology),
      Flashcard(question: "Major hormone stimulating gastric acid secretion.", answer: "Gastrin.", category: "GI Physiology", icon: Icons.medical_services),
      Flashcard(question: "Parietal cells secrete what?", answer: "HCl and intrinsic factor.", category: "GI Physiology", icon: Icons.science),
      Flashcard(question: "Chief cells secrete what?", answer: "Pepsinogen.", category: "GI Physiology", icon: Icons.science),
      Flashcard(question: "Intrinsic factor is necessary for absorption of what?", answer: "Vitamin B₁₂ (in ileum).", category: "GI Physiology", icon: Icons.medication),
      Flashcard(question: "Main inhibitor of gastric emptying.", answer: "Presence of fats/acid in duodenum via CCK, secretin.", category: "GI Physiology", icon: Icons.block),

      // O. Pancreatic & Bile Secretion
      Flashcard(question: "Exocrine pancreas secretes mainly what?", answer: "Digestive enzymes and bicarbonate-rich fluid.", category: "GI Physiology", icon: Icons.water),
      Flashcard(question: "CCK stimulates pancreas to secrete what?", answer: "Enzyme-rich fluid.", category: "GI Physiology", icon: Icons.flash_on),
      Flashcard(question: "Secretin stimulates pancreas to secrete what?", answer: "Bicarbonate-rich fluid.", category: "GI Physiology", icon: Icons.opacity),
      Flashcard(question: "Bile is produced by which organ?", answer: "Liver.", category: "GI Physiology", icon: Icons.local_hospital),
      Flashcard(question: "Main role of bile salts.", answer: "Emulsification and micelle formation for fat absorption.", category: "GI Physiology", icon: Icons.merge),
      Flashcard(question: "Site of bile salt reabsorption.", answer: "Terminal ileum (enterohepatic circulation).", category: "GI Physiology", icon: Icons.repeat),

      // P. Renal Physiology
      Flashcard(question: "Main functions of kidney.", answer: "Excretion, regulation of ECF volume/osmolality, electrolyte balance, acid–base balance, hormone production.", category: "Renal", icon: Icons.water_drop),
      Flashcard(question: "Functional unit of kidney.", answer: "Nephron.", category: "Renal", icon: Icons.settings),
      Flashcard(question: "Types of nephrons.", answer: "Cortical (short loops) and juxtamedullary (long loops).", category: "Renal", icon: Icons.category),
      Flashcard(question: "Juxtamedullary nephrons main role.", answer: "Concentration/dilution of urine via countercurrent mechanism.", category: "Renal", icon: Icons.water_damage),
      Flashcard(question: "Define GFR.", answer: "Volume of filtrate formed per minute by both kidneys (~125 ml/min).", category: "Renal", icon: Icons.speed),
      Flashcard(question: "Normal daily glomerular filtrate.", answer: "~180 L/day.", category: "Renal", icon: Icons.timeline),
      Flashcard(question: "Glomerular filtration barrier layers.", answer: "Fenestrated endothelium, basement membrane, podocyte slit diaphragm.", category: "Renal", icon: Icons.layers),

      // Q. Endocrine Physiology
      Flashcard(question: "Define hormone.", answer: "Chemical messenger secreted into blood, acting on distant target cells.", category: "Endocrine", icon: Icons.send),
      Flashcard(question: "Main hormone classes.", answer: "Peptide/protein, steroid, amino acid derivatives.", category: "Endocrine", icon: Icons.category),
      Flashcard(question: "Anterior pituitary hormones (name four).", answer: "GH, TSH, ACTH, LH, FSH, prolactin.", category: "Endocrine", icon: Icons.list),
      Flashcard(question: "Posterior pituitary stores which hormones?", answer: "ADH and oxytocin (synthesized in hypothalamus).", category: "Endocrine", icon: Icons.storage),
      Flashcard(question: "Main action of GH.", answer: "Stimulates growth via IGF‑1, increases protein synthesis, lipolysis.", category: "Endocrine", icon: Icons.trending_up),
      Flashcard(question: "Thyroid hormones.", answer: "T₃ and T₄.", category: "Endocrine", icon: Icons.medical_services),
      Flashcard(question: "Major active thyroid hormone.", answer: "T₃ (triiodothyronine).", category: "Endocrine", icon: Icons.flash_on),
      Flashcard(question: "Layers of adrenal cortex.", answer: "Zona glomerulosa, fasciculata, reticularis.", category: "Endocrine", icon: Icons.layers),
      Flashcard(question: "Hormone of zona glomerulosa.", answer: "Aldosterone (mineralocorticoid).", category: "Endocrine", icon: Icons.water_drop),
      Flashcard(question: "Main action of insulin.", answer: "Lowers blood glucose (↑uptake, ↑glycogenesis, ↓gluconeogenesis).", category: "Endocrine", icon: Icons.trending_down),

      // R. Neurophysiology
      Flashcard(question: "Main divisions of nervous system.", answer: "CNS (brain, spinal cord) and PNS (cranial & spinal nerves).", category: "Neurophysiology", icon: Icons.account_tree),
      Flashcard(question: "Main function of cerebellum.", answer: "Coordination of movement, balance, posture.", category: "Neurophysiology", icon: Icons.balance),
      Flashcard(question: "CSF is produced mainly by what?", answer: "Chloroid plexus.", category: "Neurophysiology", icon: Icons.water_drop),
      Flashcard(question: "Where are lower motor neurons located?", answer: "Anterior horn of spinal cord.", category: "Neurophysiology", icon: Icons.location_on),
      Flashcard(question: "Example of monosynaptic reflex.", answer: "Stretch (myotatic) reflex, e.g., knee jerk.", category: "Neurophysiology", icon: Icons.flash_on),
      Flashcard(question: "Main voluntary motor pathway.", answer: "Corticospinal (pyramidal) tract.", category: "Neurophysiology", icon: Icons.directions_run),
      Flashcard(question: "Deficiency of which neurotransmitter in Parkinson's disease?", answer: "Dopamine (substantia nigra).", category: "Neurophysiology", icon: Icons.health_and_safety),
      Flashcard(question: "Primary motor area location.", answer: "Precentral gyrus (frontal lobe).", category: "Neurophysiology", icon: Icons.location_on),
      Flashcard(question: "Broca's area function.", answer: "Motor speech (speech production).", category: "Neurophysiology", icon: Icons.speaker),

      // S. Special Senses
      Flashcard(question: "Refraction occurs mainly at which two structures?", answer: "Cornea (most), lens.", category: "Special Senses", icon: Icons.remove_red_eye),
      Flashcard(question: "Accommodation is.", answer: "Change in lens shape to focus near objects.", category: "Special Senses", icon: Icons.zoom_in),
      Flashcard(question: "Photoreceptors types.", answer: "Rods and cones.", category: "Special Senses", icon: Icons.lightbulb),
      Flashcard(question: "Rods are responsible for.", answer: "Vision in dim light (scotopic), black/white.", category: "Special Senses", icon: Icons.dark_mode),
      Flashcard(question: "Cones are responsible for.", answer: "Color vision and high acuity (photopic).", category: "Special Senses", icon: Icons.palette),
      Flashcard(question: "Auditory receptor organ.", answer: "Organ of Corti in cochlea.", category: "Special Senses", icon: Icons.hearing),
      Flashcard(question: "Primary taste modalities.", answer: "Sweet, sour, salty, bitter, umami.", category: "Special Senses", icon: Icons.restaurant),
    ];
  }

  void _toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  void _nextCard() {
    if (currentIndex < flashcards.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCard() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _switchSubject(int index) {
    setState(() {
      _selectedSubjectIndex = index;
      if (index == 0) {
        selectedSubject = 'Anatomy';
        flashcards = anatomyFlashcards;
      } else {
        selectedSubject = 'Physiology';
        flashcards = physiologyFlashcards;
      }
      currentIndex = 0;
      showAnswer = false;
      _pageController.jumpToPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          '$selectedSubject Flashcards (${flashcards.length} cards)',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _selectedSubjectIndex == 0
                  ? [Colors.blue.shade800, Colors.purple.shade700]
                  : [Colors.red.shade800, Colors.orange.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book, color: Colors.white),
            onPressed: () => _showCategories(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _selectedSubjectIndex == 0
                ? [
              const Color(0xFFF0F8FF),
              const Color(0xFFE6F3FF),
              const Color(0xFFDDEEFF),
            ]
                : [
              const Color(0xFFFFF8F0),
              const Color(0xFFFFF3E6),
              const Color(0xFFFFEEDD),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Subject selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment<int>(
                      value: 0,
                      label: Text('Anatomy'),
                      icon: Icon(Icons.local_hospital),
                    ),
                    ButtonSegment<int>(
                      value: 1,
                      label: Text('Physiology'),
                      icon: Icon(Icons.favorite),
                    ),
                  ],
                  selected: {_selectedSubjectIndex},
                  onSelectionChanged: (Set<int> newSelection) {
                    _switchSubject(newSelection.first);
                  },
                  style: SegmentedButton.styleFrom(
                    backgroundColor: Colors.white,
                    selectedBackgroundColor: _selectedSubjectIndex == 0
                        ? Colors.blue.shade100
                        : Colors.red.shade100,
                    selectedForegroundColor: _selectedSubjectIndex == 0
                        ? Colors.blue.shade800
                        : Colors.red.shade800,
                  ),
                ),
              ),
              // Progress indicator
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${currentIndex + 1} / ${flashcards.length}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _selectedSubjectIndex == 0
                            ? Colors.blue.shade800
                            : Colors.red.shade800,
                      ) ??
                          const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedSubjectIndex == 0
                            ? Colors.blue.shade100
                            : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        flashcards[currentIndex].category,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedSubjectIndex == 0
                              ? Colors.blue.shade700
                              : Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Flashcard PageView with flip animation
              Expanded(
                flex: 1,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                      showAnswer = false;
                    });
                  },
                  itemCount: flashcards.length,
                  itemBuilder: (context, index) {
                    final card = flashcards[index];
                    return GestureDetector(
                      onTap: _toggleAnswer,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: showAnswer ? 0.0 : pi,
                          end: showAnswer ? pi : 0.0,
                        ),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutBack,
                        builder: (context, value, child) {
                          final isFront = value < (pi / 2);
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(value),
                            child: isFront
                                ? _buildCardFront(card)
                                : Transform(
                              alignment: Alignment.center,
                              transform:
                              Matrix4.identity()..rotateY(pi),
                              child: _buildCardBack(card),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // Navigation & Action buttons
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: "prev",
                      onPressed: _previousCard,
                      mini: true,
                      backgroundColor: _selectedSubjectIndex == 0
                          ? Colors.blue.shade600
                          : Colors.red.shade600,
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white),
                    ),
                    ElevatedButton.icon(
                      onPressed: _toggleAnswer,
                      icon: Icon(showAnswer
                          ? Icons.question_mark
                          : Icons.lightbulb_outline),
                      label: Text(showAnswer ? 'Question' : 'Answer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSubjectIndex == 0
                            ? Colors.purple.shade600
                            : Colors.orange.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: "next",
                      onPressed: _nextCard,
                      mini: true,
                      backgroundColor: _selectedSubjectIndex == 0
                          ? Colors.green.shade600
                          : Colors.green.shade600,
                      child: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardFront(Flashcard card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Card(
        elevation: 12,
        shadowColor: _selectedSubjectIndex == 0
            ? Colors.blue.shade200
            : Colors.red.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: _selectedSubjectIndex == 0
                  ? [
                Colors.white,
                Colors.blue.shade50.withOpacity(0.7),
              ]
                  : [
                Colors.white,
                Colors.red.shade50.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getCategoryColor(card.category).withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getCategoryColor(card.category).withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Icon(
                  card.icon,
                  size: 36,
                  color: _getCategoryColor(card.category),
                ),
              ),
              const SizedBox(height: 24),
              Icon(
                Icons.help_outline,
                size: 48,
                color: _selectedSubjectIndex == 0 ? Colors.blue : Colors.red,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: Text(
                    card.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to flip',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardBack(Flashcard card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Card(
        elevation: 12,
        shadowColor: _selectedSubjectIndex == 0
            ? Colors.green.shade200
            : Colors.orange.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: _selectedSubjectIndex == 0
                  ? [
                Colors.white,
                Colors.green.shade50.withOpacity(0.7),
              ]
                  : [
                Colors.white,
                Colors.orange.shade50.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Answer icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _selectedSubjectIndex == 0
                      ? Colors.green.withOpacity(0.2)
                      : Colors.orange.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedSubjectIndex == 0
                        ? Colors.green.withOpacity(0.4)
                        : Colors.orange.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 36,
                  color: _selectedSubjectIndex == 0 ? Colors.green : Colors.orange,
                ),
              ),
              const SizedBox(height: 24),
              Icon(
                Icons.lightbulb,
                size: 48,
                color: _selectedSubjectIndex == 0 ? Colors.amber : Colors.yellow.shade700,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedSubjectIndex == 0
                          ? Colors.green.shade50
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: _selectedSubjectIndex == 0
                              ? Colors.green.shade200
                              : Colors.orange.shade200),
                    ),
                    child: Text(
                      card.answer,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: _selectedSubjectIndex == 0
                            ? Colors.green.shade800
                            : Colors.orange.shade800,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to flip back',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    // Anatomy colors
    if (selectedSubject == 'Anatomy') {
      switch (category) {
        case 'General Anatomy':
          return Colors.blue;
        case 'Bones':
          return Colors.orange;
        case 'Joints':
          return Colors.green;
        case 'Muscles':
          return Colors.deepPurple;
        case 'Skin':
          return Colors.pink;
        case 'Histology':
          return Colors.teal;
        case 'Embryology':
          return Colors.indigo;
        default:
          return Colors.grey;
      }
    } else {
      // Physiology colors
      switch (category) {
        case 'General Physiology':
          return Colors.red;
        case 'Cell Physiology':
          return Colors.purple;
        case 'Blood Physiology':
          return Colors.blue;
        case 'Coagulation':
          return Colors.deepOrange;
        case 'Immunity':
          return Colors.green;
        case 'Nerve Physiology':
          return Colors.indigo;
        case 'Muscle Physiology':
          return Colors.brown;
        case 'Blood Details':
          return Colors.cyan;
        case 'Respiratory':
          return Colors.teal;
        case 'GI Physiology':
          return Colors.amber.shade800;
        case 'Renal':
          return Colors.lightBlue;
        case 'Endocrine':
          return Colors.pink;
        case 'Neurophysiology':
          return Colors.deepPurple;
        case 'Special Senses':
          return Colors.orange;
        default:
          return Colors.grey;
      }
    }
  }

  void _showCategories() {
    final categories = _getUniqueCategories();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                '$selectedSubject Categories (${flashcards.length} total cards)',
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final count = flashcards
                        .where((c) => c.category == category)
                        .length;
                    final firstIndex = flashcards.indexWhere(
                            (c) => c.category == category);

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        if (firstIndex != -1) {
                          _pageController.animateToPage(
                            firstIndex,
                            duration:
                            const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            currentIndex = firstIndex;
                            showAnswer = false;
                          });
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Showing $category ($count cards)'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                          _getCategoryColor(category).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _getCategoryColor(category)
                                .withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                              _getCategoryColor(category)
                                  .withOpacity(0.3),
                              child: Icon(
                                Icons.category,
                                size: 20,
                                color: _getCategoryColor(category),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _getCategoryColor(category),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '$count cards',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getUniqueCategories() {
    return flashcards.map((c) => c.category).toSet().toList();
  }
}

class Flashcard {
  final String question;
  final String answer;
  final String category;
  final IconData icon;

  Flashcard({
    required this.question,
    required this.answer,
    required this.category,
    required this.icon,
  });
}
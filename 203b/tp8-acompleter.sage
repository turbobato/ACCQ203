print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP8 : PRIMALITE DES ENTIERS                                                 #
# *************************************************************************** #
# *************************************************************************** #
""")

# CONSIGNES
#
# Les seules lignes a modifier sont annoncee par "Code pour l'exercice"
# indique en commmentaire et son signalees
# Ne changez pas le nom des variables
#
# CONSEILS
#
# Ce modele vous sert a restituer votre travail. Il est deconseille d'ecrire
# une longue suite d'instruction et de debugger ensuite. Il vaut mieux tester
# le code que vous produisez ligne apres ligne, afficher les resultats et
# controler que les objets que vous definissez sont bien ceux que vous attendez.
#
# Vous devez verifier votre code en le testant, y compris par des exemples que
# vous aurez fabrique vous-meme.
#


reset()
print("""\
# ****************************************************************************
# TEST DE RABIN-MILLER 
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n = 561

# Code pour l'EXERCICE

def testRM(n):
    return ZZ(n).is_prime() # A MODIFIER

# # Affichage des resultats

print("Test de la primalite de n=",n,"avec implementation de Rabin-Miller")
print(testRM(n))

print("""\
# ****************************************************************************
#  PERFORMANCES DE RABIN-MILLER
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

nmin=10
nmax=500
nbtests = 1

# Code pour l'EXERCICE

rep2 = "A compléter - réponse à la Q2"
rep3 = "A compléter - réponse à la Q3"

# # Affichage des resultats

bar_chart( [sum( [testRM(n) for i in range(nbtests)]) for n in range(nmin,nmax)])
print(rep2)
print(rep3)
list_plot( [timeit( 'testRM(n)', number=20, repeat=3, seconds=true) for n in range(1001,1001+100000,100) ])


reset()
print("""\
# ****************************************************************************
# TEST DE SOLOVAY-STRASSEN 
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n = 561

# Code pour l'EXERCICE

def testRM(n):
    return ZZ(n).is_prime() # A MODIFIER

rep3 = "A compléter - réponse à la Q3"
rep4 = "A compléter - réponse à la Q4"

# # Affichage des resultats

print("Test de la primalite de n=",n,"avec implementation de Solovay-Strassen")
print(testRM(n))
print(rep3)
print(rep4)


reset()
print("""\
# ****************************************************************************
# COMPARAISON ENTRE LES TESTS DE R-M ET S-S 
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

nmax=150

# Code pour l'EXERCICE

Temoins = []

# # Affichage des resultats

print("Liste d'entiers composés et de temoins exclusifs de Rabin-Miller")
print(Temoins)



reset()
print("""\
# ****************************************************************************
# TEST DE LUCAS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE

def testL(n):
    return ZZ(n).is_prime() # A MODIFIER

# # Affichage des resultats

for _ in range(1):
    n =  ZZ.random_element(2,3)
    print(n.is_prime()==testL(n))



reset()
print("""\
# ****************************************************************************
# TEST DE BAILLIE, POMERANCE, SELFRIDGE ET WAGSTAFF
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

nmax=1000

# Code pour l'EXERCICE

def testBPSW(n):
    return ZZ(n).is_prime() # A MODIFIER

# # Affichage des resultats

print(all([ZZ(n).is_prime()==testBPSW(n) for n in range(2,nmax+1)]))


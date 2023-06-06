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
    a = randint(2,n-1)
    m = n-1
    v = 0
    while m % 2 == 0 :
        m = m/2
        v+=1
    g = gcd(a,n)
    if g > 1 :
        return False
    b = a^m % n
    if b == 1 :
        return True
    for i in range(1,v+1) :
        if b^2 % n == 1:
            g = gcd(b+1,n)
            if g == 1 or  g == n :
                return True
            else :
                return False
        b = b^2 % n
    return False
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
nbtests = 10

# Code pour l'EXERCICE

rep2 = "On a par exemple 15 et 21 qui sont souvent déclarés premiers alors que composés. On constate qu'ils sont en fait produits de deux nombres premiers distincts."
rep3 = "Il faut que 1/4^nbtests < 2^-50, c'est à dire qu'il faut faire au moins 25 tests pour assurer une probabilité d'erreur de au plus 2^-50"

# # Affichage des resultats

print(rep2)
print(rep3)
list_plot( [timeit( 'testRM(n)', number=20, repeat=3, seconds=true) for n in range(1001,1001+100000,100) ])
bar_chart( [1/nbtests * sum( [testRM(n) for i in range(nbtests)]) for n in range(nmin,nmax)])

reset()
print("""\
# ****************************************************************************
# TEST DE SOLOVAY-STRASSEN 
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n = 561

# Code pour l'EXERCICE

nmin=10
nmax=500
nbtests = 10

def testSS(n):
    if n%2 == 0 :
        return False
    a = randint(2,n-1)
    if gcd(a,n) > 1 : 
        return False
    g = a^((n-1)/2) %n
    if (jacobi_symbol(a,n)%n) == g :
        return True
    else :
        return False

rep3 = "On a par exemple 15, 25 et 27, qui sont des nombres ayant au plus deux facteurs premiers distincts"
rep4 = "Ici la probabilité de trouver un témoin de Solovay parmi les inversibles modulo n est d'au plus 1/2, donc il faut faire 50 tests pour assurer une probabilité de faux diagnostic inférieure à 2^-50"

# # Affichage des resultats

print("Test de la primalite de n=",n,"avec implementation de Solovay-Strassen")
print(testSS(n))
print(rep3)
print(rep4)

bar_chart( [1/nbtests * sum( [testSS(n) for i in range(nbtests)]) for n in range(nmin,nmax)])
reset()
print("""\
# ****************************************************************************
# TEST DE LUCAS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE

def testL(n,p,q):
    if n == 2 :
        return True
    else :
        delta = p^2 - 4*q
        g = gcd(n,2*q*delta)
        if g > 1 and n > g :
            return False
        elif g == n :
            print("Mauvais choix de p, q")
            return None
        eps = n - jacobi_symbol(delta,n)
        m = eps
        t = 0
        while m%2==0 :
            m = m/2
            t+=1
        U = [0,1]
        for i in range(2,m+1) :
            U.append(p*U[i-1]-q*U[i-2])
        V = [2,p]
        for i in range(2,n+1) :
            V.append(p*V[i-1]-q*V[i-2])
        g = gcd(n,U[m])
        if g > 1 and n > g :
            return False
        elif g == n :
            return True
        for i in range(0,t) :
            g = gcd(n,V[(2^i)*m])
            if g > 1 and n > g :
                return False
            elif g == n :
                return True
        return False

# # Affichage des resultats

for _ in range(1):
    n =  ZZ.random_element(2,3)
    print(n.is_prime()==testL(n, 4, 9))

print("""\
# ****************************************************************************
# TEST DE BAILLIE, POMERANCE, SELFRIDGE ET WAGSTAFF
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

nmax=1000

# Code pour l'EXERCICE

def suite(k) :
    return (-1)^k*(2*k+5)

def testRabinMillnerAFixe(n,a) :
    m = n-1
    v = 0
    while m % 2 == 0 :
        m = m/2
        v+=1
    g = gcd(a,n)
    if g > 1 :
        return False
    b = pow(Mod(a,n),m)
    if b == 1 :
        return True
    for i in range(1,v+1) :
        if (b^2 % n) == 1:
            g = gcd(b+1,n)
            if g == 1 or  g == n :
                return True
            else :
                return False
        b = b^2 % n
    return False

def testBPSW(n):
    if n == 2 :
        return True
    else :
        if not testRabinMillnerAFixe(n,2) :
            return False
        k = 0
        delta = suite(k)
        while jacobi_symbol(delta,n) != - 1 :
            k+=1
            delta = suite(k)
        p, q= 1, (1-delta)/4
        if not testL(n,p,q) :
            return False
        return True

# # Affichage des resultats

print(all([ZZ(n).is_prime()==testBPSW(n) for n in range(2,nmax+1)]))


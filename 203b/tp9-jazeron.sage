print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP9 : FACTORISATION DES ENTIERS                                             #
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
# DIVISEURS SUCCESSIFS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2*3*3*5*5*5*7*11*11

# Code pour l'EXERCICE

def div_successives(n):
    F = set()
    d = 2
    while d^2 <= n :
        while n % d == 0 :
            n = n/d
            F.add(d)
        d+=1
    if n != 1 :
        F.add(n)
    return list(F)

# # Affichage des resultats

print(div_successives(n))
for n in range(2,10):
    assert(div_successives(ZZ(n))==ZZ(n).prime_divisors())


reset()
print("""\
# ****************************************************************************
# FACTORISATION D'UN NOMBRE B-FRIABLE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2*3*3*5*5*5*7*11*11
P=[p for p in primes(12)]

# Code pour l'EXERCICE

def div_successives_friable(n, P):
    F = set()
    for p in P :
        while n % p == 0 :
            n = n/p
            F.add(p)
    return list(F)

# # Affichage des resultats

print(div_successives_friable(n,P))
for n in range(2,10):
    assert(div_successives_friable(ZZ(n),P)==ZZ(n).prime_divisors())


reset()
print("""\
# ****************************************************************************
# RHO DE POLLARD
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=222763

# Code pour l'EXERCICE

def myPollardrho(n):
    x=Integer(Integers(n).random_element())
    y = x
    f = lambda x : (x^2 + 1) % n
    x = f(x)
    y = f(f(y))
    g = gcd(x-y,n)
    while g <= 1 :
        x = f(x)
        y = f(f(y))
        g = gcd(x-y,n)
    if g == n :
        return "Echec"
    else : 
        return f"{g} est un facteur"

# # Affichage des resultats

print(myPollardrho(n))

for _ in range(5):
    n=ZZ.random_element(3,100)
    print(n)
    print(n, 
      "| Resultat rho de Pollard : ", 
      myPollardrho(n), 
      " | n est-il composé ?",not n.is_prime())




reset()
print("""\
# ****************************************************************************
# P-1 DE POLLARD
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=1323269

# Code pour l'EXERCICE

def myPollardpm1(n,b):
    a = randint(2,n-1)
    g = gcd(n,a)
    if g > 1 : 
        return f"{g} est un facteur"
    for p in primes(b) :
        alpha = 1 
        while p^alpha <= b :
            alpha+=1
        for j in range(1,alpha):
            a = a^p % n
    g = gcd(a-1,n)
    if g > 1 and g < n :
        return f"{g} est un facteur"
    else :
        return "Echec"


# # Affichage des resultats

myPollardpm1(n,1000)

for _ in range(5):
    n=ZZ.random_element(3,100)
    print(n, 
      "| Resultat rho de Pollard : ", 
      myPollardpm1(n,100), 
      " | n est-il composé ?",not n.is_prime())




reset()
print("""\
# ****************************************************************************
# CRIBLE QUADRATIQUE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2886

# Code pour l'EXERCICE

def cribleQuadratique (n):
    B = ceil(exp(sqrt(ln(n)*ln(ln(n)))))
    premiers = set(primes(B))
    m = len(premiers)
    count = 0
    friables = []
    x = ceil(sqrt(n))
    while True :
        a = x^2 % n
        if a != 0 :
            facteurs = prime_divisors(a)
            if all([p in premiers for p in facteurs]) :
                friables.append((x,a))
                count+=1
            if count == m+1 :
                break
        x+=1
    
    M = matrix(ZZ,m,len(friables))

    for i in range(len(friables)) :
        (x,a) = friables[i]
        liste_premier = list(premiers)
        for j in range(len(liste_premier)) :
            M[j,i] = 0
            while (a % liste_premier[j]) == 0 :
                M[j,i]+=1
                a = a/liste_premier[j]
    
    M_F2 = matrix(FiniteField(2),M)
    v = M_F2.right_kernel().basis()[0]
    support = []
    for i in range(len(friables)) :
        if v[i] != 0 :
            support.append(i)
    z = 1 
    for i in support :
        x,a = friables[i]
        z = z*x % n
    y = 1 
    for i in range(m) :
        somme = 0
        for j in support :
            somme += M[i,j]
        somme = somme/2
        y = ((liste_premier[i]^somme) * y) % n
    d = gcd(z-y,n)
    return d
                
# # Affichage des resultats

print(cribleQuadratique(n))

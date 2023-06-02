const toastTrigger = document.getElementById('bontonEnviar')
const toastLive = document.getElementById('liveToast')

if (toastTrigger) {
    const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLive)

    toastTrigger.addEventListener('click', () => {
        toastBootstrap.show()
    })
} 

const toastTrigger2 = document.getElementById('bontonComentar')
const toastLive2 = document.getElementById('comentarioToast')

if (toastTrigger2) {
    const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLive2)

    toastTrigger2.addEventListener('click', () => {
        toastBootstrap.show()
    })
}